$fn = 64;

Floppy35Size = [90, 93.5];
Floppy35Thickness = 3.2;

HOLE_RADIUS_FOR_M3 = 3.5 / 2;

// https://www.digikey.com.au/products/en/hardware-fasteners-accessories/bumpers-feet-pads-grips/570?FV=69%7C400526%2C69%7C411854%2C-8%7C570&quantity=0&ColumnSort=1000011&page=1&stock=1&pageSize=25
// https://www.digikey.com.au/product-detail/en/keystone-electronics/720/36-720-ND/61956
KEYSTONE_720_FEET_SIZE = [12.7 / 2, 6.4]; // [radius, height]

function holePositions(diskSize, feetSize) = [
    feetSize[0],
    feetSize[0] * 3 + diskSize[0],
    feetSize[0],
    feetSize[0] * 3 + diskSize[1]
];

module MainCoasterShape(diskSize, feetSize)
{
    feetRadius = feetSize[0];

    size = diskSize + [feetRadius * 4, feetRadius * 4];

    echo(str("Coaster size: ", size));

    cornerX1 =           feetRadius;
    cornerX2 = size[0] - feetRadius;
    cornerY1 =           feetRadius;
    cornerY2 = size[1] - feetRadius;

    hull()
    {
        translate([cornerX1, cornerY1]) circle(r=feetRadius);
        translate([cornerX1, cornerY2]) circle(r=feetRadius);
        translate([cornerX2, cornerY1]) circle(r=feetRadius);
        translate([cornerX2, cornerY2]) circle(r=feetRadius);
    }
}

module FloppyCoaster(diskSize, holeRadius, feetSize, cutoutForDisk)
{
    holePositions = holePositions(diskSize, feetSize);
    holeX1 = holePositions[0];
    holeX2 = holePositions[1];
    holeY1 = holePositions[2];
    holeY2 = holePositions[3];

    difference()
    {
        // Main shape of coaster
        MainCoasterShape(diskSize, feetSize);

        // Cut out for disk
        if (cutoutForDisk)
        {
            translate([feetSize[0] * 2 - 0.5, feetSize[0] * 2 - 0.5])
            square(diskSize + [1, 1]);
        }

        // Holes for screws
        translate([holeX1, holeY1]) circle(r=holeRadius);
        translate([holeX1, holeY2]) circle(r=holeRadius);
        translate([holeX2, holeY1]) circle(r=holeRadius);
        translate([holeX2, holeY2]) circle(r=holeRadius);
    }
}

module StackUp(diskSize, holeRadius, feetSize)
{
    feltThickness = 2;
    baseThickness = 1;
    diskThickness = Floppy35Thickness;
    coverThickness = 1;

    // Feet
    holePositions = holePositions(diskSize, feetSize);
    feetX1 = holePositions[0];
    feetX2 = holePositions[1];
    feetY1 = holePositions[2];
    feetY2 = holePositions[3];
    color("black")
    translate([0, 0, -10])
    {
        translate([feetX1, feetY1]) cylinder(r=feetSize[0], h=feetSize[1]);
        translate([feetX1, feetY2]) cylinder(r=feetSize[0], h=feetSize[1]);
        translate([feetX2, feetY1]) cylinder(r=feetSize[0], h=feetSize[1]);
        translate([feetX2, feetY2]) cylinder(r=feetSize[0], h=feetSize[1]);
    }

    // Felt
    color("gray")
    translate([0, 0, 0])
    linear_extrude(feltThickness)
    FloppyCoaster(diskSize, holeRadius, feetSize, false);

    // Base
    color("black")
    translate([0, 0, 10])
    linear_extrude(baseThickness)
    FloppyCoaster(diskSize, holeRadius, feetSize, false);

    // Surround the disk
    color("orange")
    translate([0, 0, 20])
    linear_extrude(diskThickness)
    FloppyCoaster(diskSize, holeRadius, feetSize, true);

    // Cover
    color("orange", 0.25)
    translate([0, 0, 30])
    linear_extrude(coverThickness)
    FloppyCoaster(diskSize, holeRadius, feetSize, false);
}
