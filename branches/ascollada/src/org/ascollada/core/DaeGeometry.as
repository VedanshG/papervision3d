/*
 * Copyright 2007 (c) Tim Knip, ascollada.org.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
 
package org.ascollada.core 
{
	import org.ascollada.ASCollada;
	import org.ascollada.physics.DaeConvexMesh;
	import org.ascollada.utils.Logger;
	
	/**
	 * 
	 */
	public class DaeGeometry extends DaeEntity
	{	
		public var convex_mesh:DaeConvexMesh;
		
		public var mesh:DaeMesh;
		
		public var spline:XML;
		
		/**
		 * 
		 * @param	node
		 */
		public function DaeGeometry( node:XML = null )
		{
			super( node )
		}
		
		/**
		 * 
		 * @return
		 */
		override public function read( node:XML ):void {
			super.read( node );
			
			Logger.trace( "reading geometry: " + this.id );
			
			var meshNode:XML = getNode( node, ASCollada.DAE_CONVEX_MESH_ELEMENT );	
			if( !meshNode ) {
				meshNode = getNode( node, ASCollada.DAE_MESH_ELEMENT );
				if( !meshNode) {
					meshNode = getNode( node, ASCollada.DAE_SPLINE_ELEMENT );	
				}
			}
			
			if( !meshNode ) {
				Logger.error( "expected one of <convex_mesh>, <mesh> or <spline>!" );
				throw new Error( "expected one of <convex_mesh>, <mesh> or <spline>!" );
			}
			
			switch( meshNode.localName() ) 	{
				case ASCollada.DAE_CONVEX_MESH_ELEMENT:
					this.convex_mesh = new DaeConvexMesh( meshNode );
					break;
				case ASCollada.DAE_MESH_ELEMENT:
					this.mesh = new DaeMesh( meshNode );
					break;
				case ASCollada.DAE_SPLINE_ELEMENT:
					throw new Error( "<spline> not yet supported!" );
					break;
				default:
					break;
			}
		}
	}	
}