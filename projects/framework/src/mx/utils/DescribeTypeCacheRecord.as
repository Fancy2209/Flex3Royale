////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2005-2006 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.utils 
{

import mx.utils.Proxy;
COMPILE::SWF {import flash.utils.flash_proxy;}

[ExcludeClass]

/**
 *  This class represents a single cache entry, this gets created
 *  as part of the <code>describeType</code> method call on the 
 *  <code>DescribeTypeCache</code>  class.
 */

public dynamic class DescribeTypeCacheRecord extends Proxy
{
	//--------------------------------------------------------------------------
	//
	//  Class variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private var cache:Object = {};
	
	//--------------------------------------------------------------------------
	//
	//  Class properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  typeDescription
	//----------------------------------

	/**
	 *  @private
	 */
	public var typeDescription:XML;
	
	//----------------------------------
	//  typeName
	//----------------------------------

	/**
	 *  @private
	 */
	public var typeName:String;

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	public function DescribeTypeCacheRecord()
	{
		super();
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	COMPILE::SWF
	override flash_proxy function getProperty(name:*):*
	{
		return proxy_getProperty(name);
	}
	/**
	 *  @private
	 */
	COMPILE::JS
	override public function getProperty(name:String):*
	{
		return proxy_getProperty(name);
	}

	/**
	 *  @private
	 */
	private function proxy_getProperty(name:*):*
	{
		var result:* = cache[name];
		
		if (result === undefined)
		{
			result = DescribeTypeCache.extractValue(name, this);
			cache[name] = result;
		}
		
		return result;
	}

	COMPILE::SWF
	override flash_proxy function hasProperty(name:*):Boolean
	{
		return proxy_hasProperty(name);
	}
	/**
	 *  @private
	 */
	COMPILE::JS
	override public function hasProperty(name:String):Boolean
	{
		return proxy_hasProperty(name);
	}

	/**
	 *  @private
	 */
	private function proxy_hasProperty(name:*):Boolean
	{
		if (name in cache)
			return true;
		
		var value:* = DescribeTypeCache.extractValue(name, this);		
		
		if (value === undefined)
			return false;
		
		cache[name] = value;
		
		return true;
	}
}

}
