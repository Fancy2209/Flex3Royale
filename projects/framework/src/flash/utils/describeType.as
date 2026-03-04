package flash.utils
{

    import org.apache.royale.reflection.describeType;
    import org.apache.royale.reflection.TypeDefinition;
    import org.apache.royale.reflection.getQualifiedClassName;
    import org.apache.royale.reflection.AccessorDefinition;
    import org.apache.royale.reflection.MetaDataDefinition;
    import org.apache.royale.reflection.MetaDataArgDefinition;
    import org.apache.royale.reflection.MethodDefinition;
    import org.apache.royale.reflection.ParameterDefinition;

    // TODO: Factory tag
    public function describeType(value:*):XML
    {
        function toFlashQualifiedName(royaleQname:String):String {
            if(royaleQname.indexOf(".") == -1) return royaleQname;

            var parts:Array = royaleQname.split(".");
            var typeName:String = parts.pop();
            return parts.join(".") + "::" + typeName;
        }
        var i:int = 0;
        var j:int = 0;
        var k:int = 0;
        var meta:MetaDataDefinition;
        var metaXML:XML;

        var typeDesc:XML = <type><script/></type>;

        var typeDef:TypeDefinition = org.apache.royale.reflection.describeType(value);
        typeDesc.@name = toFlashQualifiedName(typeDef.qualifiedName);
        typeDesc.@base = toFlashQualifiedName((typeDef.baseClasses[typeDef.baseClasses.length - 1] as TypeDefinition).qualifiedName); // TODO: Should be first, or last?

        // TODO: I don't think Royale exposes these?
        typeDesc.@isDynamic = false;
        typeDesc.@isFinal = false;
        typeDesc.@isStatic = false;

        for (i = 0; i < typeDef.baseClasses.length; i++)
        {
            typeDesc.appendChild(<extendsClass type={toFlashQualifiedName((typeDef.baseClasses[i] as TypeDefinition).qualifiedName)}/>);
        }

        for (i = 0; i < typeDef.interfaces.length; i++)
        {
            typeDesc.appendChild(<implementsInterface type={toFlashQualifiedName(org.apache.royale.reflection.getQualifiedClassName(typeDef.interfaces[i] as Class))}/>);
        }

        for (i = 0; i < typeDef.accessors.length; i++)
        {
            var accessor:AccessorDefinition = typeDef.accessors[i];
            var accessorXML:XML = <accessor name={accessor.name} access={accessor.access} type={toFlashQualifiedName(accessor.type.qualifiedName)} declaredBy={toFlashQualifiedName(accessor.declaredBy.qualifiedName)}/>;
            for (j = 0; j < accessor.metadata.length; j++)
            {
                meta = accessor.metadata[j];
                metaXML = <metadata name={meta.name}></metadata>;
                for (k = 0; k < meta.args.length; k++)
                {
                    var arg:MetaDataArgDefinition = meta.args[k];
                    metaXML.appendChild(<arg key={arg.key} value={arg.value}/>);
                }
                accessorXML.appendChild(metaXML);
            }
            typeDesc.appendChild(accessorXML);
        }

        for (i = 0; i < typeDef.methods.length; i++)
        {
            var method:MethodDefinition = typeDef.methods[i];
            var methodXML:XML = <method name={method.name} declaredBy={toFlashQualifiedName(method.declaredBy.qualifiedName)} returnType={toFlashQualifiedName(method.returnType.qualifiedName)}/>;
            for (j = 0; j < method.parameters.length; j++)
            {
                var parameter:ParameterDefinition = method.parameters[j];
                var parameterXML:XML = <parameter index={parameter.index} type={toFlashQualifiedName(parameter.type.qualifiedName)} optional={parameter.optional} />;

                methodXML.appendChild(parameterXML);
            }

            for (j = 0; j < method.metadata.length; j++)
            {
                meta = method.metadata[j];
                metaXML = <metadata name={meta.name}></metadata>;
                for (k = 0; k < meta.args.length; k++)
                {
                    var methodArg:MetaDataArgDefinition = meta.args[k];
                    metaXML.appendChild(<arg key={methodArg.key} value={methodArg.value}/>);
                }
                methodXML.appendChild(metaXML);
            }
            typeDesc.appendChild(methodXML);
        }

        return typeDesc;
    }
}