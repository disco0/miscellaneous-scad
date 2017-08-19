use <hershey.scad>;

//<params>
name = "NAME";
font = 10; // [0:cursive, 1:futural, 2:futuram, 3:gothgbt, 4:gothgrt, 5:gothiceng, 6:gothicger, 7:gothicita, 8:gothitt, 9:rowmand, 10:rowmans, 11:rowmant, 12:scriptc, 13:scripts, 14:timesi, 15:timesib, 16:timesr, 17:timesrb]
textSize = 30;
lineHeight = 8;
lineWidth = 10;
lineChamfer = 4;
smartOverlap = 1; // [1:yes, 0:no]
// increase to make letters be more squashed together
letterSquish = 5;
// set to 0 not to include ring
ringOuterDiameter = 14; 
ringLineWidth = 3.5;
ringHeight = 5;
// 0.5 is vertically centered; 0 is at the bottom and 1 is at the top
ringPosition = 0.5; 
//</params>

fonts=["cursive","futural","futuram","gothgbt","gothgrt","gothiceng","gothicger","gothicita","gothitt","rowmand","rowmans","rowmant","scriptc","scripts","timesi","timesib","timesr","timesrb"];


module chamferedCylinder(d=10,r=undef,h=10,chamfer=1) {
    diameter = r==undef ? d : 2*r;
    cylinder(d=diameter,h=h-chamfer+0.001);
    translate([0,0,h-chamfer])
    cylinder(d1=diameter,d2=diameter-chamfer*2,h=chamfer);
}

drawHersheyText(name, font=fonts[font], size=textSize, extraSpacing=smartOverlap ? 0 : -letterSquish, forceMinimumDistance=smartOverlap ? max(0,lineWidth-letterSquish) : undef) chamferedCylinder(d=lineWidth,h=lineHeight,chamfer=lineChamfer, $fn=24);

ringInnerDiameter = ringOuterDiameter - 2*ringLineWidth;

if (ringOuterDiameter>0) {
    render(convexity=2)
    translate([-ringInnerDiameter/2,textSize*ringPosition,0])
    difference() {
        cylinder(d=ringOuterDiameter,h=ringHeight);
        translate([0,0,-1])
        cylinder(d=ringInnerDiameter,h=ringHeight+2);
    }
}
