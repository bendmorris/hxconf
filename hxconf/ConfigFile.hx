package hxconf;


class ConfigFile
{
	static var comment:EReg = ~/^#.*/;
	static var section:EReg = ~/^\[([^\]]+)\]/;
	static var def:EReg = ~/^([^:=]+)[:=](.*)/;

	public var settings:Map<String, Map<String, String>>;

	public function new()
	{
		settings = new Map();
	}

	public function read(contents:String)
	{
		var lines = contents.split('\n');
		var currentSection = "";
		var lastDef = null;
		for (line in lines)
		{
			line = StringTools.trim(line);
			if (line.length == 0) continue;
			if (comment.match(line)) continue;
			else if (section.match(line))
			{
				// new section
				currentSection = section.matched(1);
			}
			else if (def.match(line))
			{
				// new setting
				if (!settings.exists(currentSection))
					settings[currentSection] = new Map();
				settings[currentSection][def.matched(1)] = def.matched(2);
				lastDef = def.matched(1);
			}
			else
			{
				// continuation line
				if (lastDef == null)
					throw "Config formatting error";
				settings[currentSection][lastDef] += " " + line;
			}
		}
	}

	public function exists(section:String, key:String)
	{
		return settings.exists(section) && settings[section].exists(key);
	}

	public function get(section:String, key:String)
	{
		return settings[section][key];
	}

	public function getAll(section:String)
	{
		return settings[section];
	}
}
