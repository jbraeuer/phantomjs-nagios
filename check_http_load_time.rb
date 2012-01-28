#!/usr/bin/env ruby

require 'json'
require 'uri'
require 'date'
require 'time'
require 'optparse'

# Xvfb :1 -nolisten tcp -screen 1 1600x1200x16 &

options = {}
options[:phantomjs] = "/usr/bin/phantomjs --load-images=yes --load-plugins=yes --local-to-remote-url-access=yes --disk-cache=no"
options[:snifferjs] = "/root/netsniff.js"
options[:display]   = ":1"
options[:warning]   = 1.0
options[:critical]  = 2.0

OptionParser.new do |opts|
	opts.banner = "Usage: {$0} [options]"

	opts.on("-s", "--sniffer [STRING]", "path to phantomjs netsniff" ) do |s|
		options[:snifferjs] = s
	end
	opts.on("-u", "--url [STRING]", "URL to query" ) do |u|
		options[:url] = u
	end
	opts.on("-w", "--warning [FLOAT]", "Time when warning") do |w|
		otions[:warning] = w
	end
	opts.on("-c", "--critical [FLOAT]", "Time when critical") do |c|
		otions[:critical] = c
	end
end.parse!

website_url = URI(options[:url])
website_load_time = 0.0

# Run Phantom
output = IO.popen("env DISPLAY=" + options[:display] + " " + options[:phantomjs] + " " + options[:snifferjs] + " " + website_url.to_s + " 2> /dev/null" )

json = output.readlines
begin
	hash = JSON.parse(json.join)
rescue
	puts "Unkown: Could not parse JSON from phantomjs"
	exit 3
end

request_global_time_start = DateTime.parse(hash['log']['pages'][0]['startedDateTime'])
request_global_time_end   = request_global_time_start

hash['log']['entries'].each do |entry|
	request_time_start       = DateTime.parse(entry['startedDateTime'])
	request_time_duration_ms = entry['time'].to_i / 1000.0
	request_time_end         = request_time_start + request_time_duration_ms

	if (request_time_end > request_global_time_end) 
		request_global_time_end = request_time_end
	end

end
website_load_time = '%.2f' % (request_global_time_end - request_global_time_start)

if website_load_time.to_f > options[:critical].to_f
	puts "Critical: #{website_url.to_s} load time: #{website_load_time.to_s}"
	exit 2
elsif website_load_time.to_f > options[:warning].to_f
	puts "Warning: #{website_url.to_s} load time: #{website_load_time.to_s}"
	exit 1
else
	puts "OK: #{website_url.to_s} load time: #{website_load_time.to_s}"
	exit 0
end






