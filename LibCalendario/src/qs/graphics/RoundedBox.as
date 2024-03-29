/*Copyright (c) 2006 Adobe Systems Incorporated

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package qs.graphics
{
	import mx.core.UIComponent;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import flash.geom.Rectangle;

	[Style(name="fill", type="mx.graphics.IFill", inherit="no")]
	[Style(name="stroke", type="mx.graphics.IStroke", inherit="no")]
	[Style(name="cornerRadius", type="Number", inherit="no")]
	[Style(name="cornerRadiusTopLeft", type="Number", inherit="no")]
	[Style(name="cornerRadiusTopRight", type="Number", inherit="no")]
	[Style(name="cornerRadiusBottomLeft", type="Number", inherit="no")]
	[Style(name="cornerRadiusBottomRight", type="Number", inherit="no")]

	public class RoundedBox extends UIComponent
	{
		private static var rc:Rectangle = new Rectangle();
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var f:IFill = getStyle("fill");
			var s:IStroke = getStyle("stroke");
			var o:Number = 0;
			var cornerRadius:Number = getStyle("cornerRadius");
			var cTL:Number = getStyle("cornerRadiusTopLeft");
			var cTR:Number = getStyle("cornerRadiusTopRight");
			var cBL:Number = getStyle("cornerRadiusBottomLeft");
			var cBR:Number = getStyle("cornerRadiusBottomRight");

			graphics.clear();
			
			if(isNaN(cornerRadius))
				cornerRadius = 0;
			if(isNaN(cTL))
				cTL = cornerRadius;
			if(isNaN(cTR))
				cTR= cornerRadius;
			if(isNaN(cBL))
				cBL = cornerRadius;
			if(isNaN(cBR))
				cBR = cornerRadius;
			
				
			
			if(s != null)
			{
				o = s.weight/2;
				unscaledHeight -=s.weight;
				unscaledWidth -= s.weight;
				s.apply(graphics,null,null);
			}
			else
				graphics.lineStyle(0,0,0);

			if(f != null)
			{
				rc.left = rc.right = o;
				rc.width = unscaledWidth;
				rc.height = unscaledHeight;
				f.begin(graphics,rc,null);
			}
			graphics.drawRoundRectComplex(o,o,unscaledWidth,unscaledHeight,
				cTL,cTR,cBL,cBR);
			if(f != null)
			{
				f.end(graphics);
			}
			
			
		}
	}
}