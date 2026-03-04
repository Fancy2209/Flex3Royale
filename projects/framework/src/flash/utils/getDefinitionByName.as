package flash.utils
{
    import flash.Lib;
    import org.apache.royale.reflection.getDefinitionByName;

    public function getDefinitionByName(name:String):*
    {
        var index:Number = name.lastIndexOf("::");
        if (index != -1)
        {
            name = name.substr(0, index) + "." + name.substr(index + 2);
        }
        var def:* = org.apache.royale.reflection.getDefinitionByName(name);
        if (def)
        {
            return def;
        }
        return flash.Lib.getDefinitionByName(name);
    }
}