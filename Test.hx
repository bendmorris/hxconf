import hxconf.ConfigFile;


class Test
{
	static function main()
	{
		var c = new hxconf.ConfigFile();
		c.read("[Section 1]
abc=def
ghi:jkl

[Database]
host=localhost
port=1234
#port=5678");

		trace(c.get("Section 1", "abc"));
		trace(c.getAll("Database"));
	}
}
