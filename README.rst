Nagios load test for Websites
=============================

This Nagios/Icinga plugin measure the complete load of an website.

PhantomJS - headless WebKit
+++++++++++++++++++++++++++

This Nagios plugin uses `PhantomJS`_ for testing the load time. PhantomJS
downloads and render the website as you are doing it with Firefox.

This test fetchs also all images/css/js files.

Command line
++++++++++++

- -u http://www.fotokasten.de/
- -c 2.0 ``[second]``
- -w 1.0 ``[second]``

run check
+++++++++
        ./check_http_load_time.rb -u http://www.fotokasten.de -c 5 -w 4

        OK: http://www.fotokasten.de load time: 2.51 | load_time=2.51

Contact?
++++++++
Jonas Genannt / http://blog.brachium-system.net

.. _PhantomJS: http://www.phantomjs.org/
.. _Xvfb: http://code.google.com/p/phantomjs/wiki/XvfbSetup
