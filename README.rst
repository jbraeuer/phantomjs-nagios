Nagios load test for Websites
=============================

This Nagios/Icinga plugin measure the complete load of an website.

PhantomJS - headless WebKit
+++++++++++++++++++++++++++

This Nagios plugin uses PhantomJS for testing the load time. PhantomJS
downloads and render the website as you are doing it with Firefox.

This test fetchs also all images/css/js files.

Command line
++++++++++++

- -u http://www.fotokasten.de/
- -c 2.0 ``[second]``
- -w 1.0 ``[second]``

Contact?
++++++++
Jonas Genannt / http://blog.brachium-system.net
