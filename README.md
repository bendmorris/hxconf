This library is for reading sectioned configuration files, similar to INI files 
or those parsed by Python's ConfigParser.


Using hxconf
------------

Example config file:

    [section1]
    foo=bar
    blah=123

    [section2]
    foo=abc
    def=ghi

Parsing and using the configuration:

    var conf = new hxconf.ConfigFile();
    conf.read(File.getContent("my_file.cfg"));
    trace(conf.get("section1", "foo"));      // traces "bar"
