using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module DistanceText {

	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var font = WatchUi.loadResource(Rez.Fonts.complication_font);
	var iconFont = WatchUi.loadResource(Rez.Fonts.icon_font);
	var accentColor;
	var useAccentColor;
	
	var icon = "K";
	var iconWidth;
	
	var distanceLocX;
	var distanceLocY;

	function drawDistance(dc, position) {
		
		useAccentColor = Application.getApp().getProperty("AccentColorComplication");
		accentColor = (useAccentColor) ? Application.getApp().getProperty("AccentColor") : Graphics.COLOR_WHITE;
	
		// Get the distance
		var info = ActivityMonitor.getInfo();
		var distance = (info.distance != null) ? info.distance / 100 : 0;
		var unit = "m";
		if (distance >= 1000) {
			distance = distance / 1000.0;
			distance = (distance * 10).toNumber().toFloat() / 10;
			distance = distance.format("%.1f");
			unit = "km";
		}
		var distanceString = Lang.format("$1$$2$", [distance, unit]);
       	
       	// Calculate position
       	var bigFontHeight = dc.getFontHeight(bigFont);
       	var distanceTextWidth = dc.getTextWidthInPixels(distanceString, font);
       	iconWidth = dc.getTextWidthInPixels(icon, iconFont);
       	if (position == 0) {// Left
       		distanceLocX = dc.getWidth() / 2 - distanceTextWidth - iconWidth - 10;
       	} else { // Right
       		distanceLocX = dc.getWidth() / 2 + 10;
       	}
       	distanceLocY = (dc.getHeight() - bigFontHeight) / 2 - 5;
       	
       	// Set date text
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       	dc.drawText(distanceLocX + 5 + iconWidth, distanceLocY, font, distanceString, Graphics.TEXT_JUSTIFY_LEFT);
       	dc.setColor(accentColor, Graphics.COLOR_BLACK);
       	dc.drawText(distanceLocX, distanceLocY, iconFont, icon, Graphics.TEXT_JUSTIFY_LEFT);
	
	}

}