//
//  TiledLayer.m
//  ZoomTest
//
//  Created by Tim Duckett on 20/06/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "TiledLayer.h"
#import <QuartzCore/CATiledLayer.h>


@implementation TiledLayer

+(Class)layerClass {
    return [CATiledLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
        tiledLayer.levelsOfDetail = 2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat scale = CGContextGetCTM(context).a;
    CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
    
    tiledLayer.tileSize = CGSizeMake(200, 200);
    CGSize tileSize = tiledLayer.tileSize;
    
    tileSize.width /= scale;
    tileSize.height /= scale;

    int firstCol = floorf(CGRectGetMinX(rect) / tileSize.width);
    int lastCol  = floorf((CGRectGetMaxX(rect)) / tileSize.width);
    int firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    int lastRow  = floorf((CGRectGetMaxY(rect)) / tileSize.height);

    for (int row = firstRow; row <= lastRow; row++) {
        
        for (int col = firstCol; col <= lastCol; col++) {
            
            UIImage *tile = [self tileForScale:scale row:row col:col];
            CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row,
                                         tileSize.width, tileSize.height);
            
            // if the tile would stick outside of our bounds, we need to truncate it so as to avoid
            // stretching out the partial tiles at the right and bottom edges
            tileRect = CGRectIntersection(self.bounds, tileRect);
            
            [tile drawInRect:tileRect];
            
            [[UIColor whiteColor] set];
            CGContextSetLineWidth(context, 1.0 / scale);
            CGContextStrokeRect(context, tileRect);

        }
    }
    
}

- (UIImage *)tileForScale:(CGFloat)scale row:(int)row col:(int)col {

    // we use "imageWithContentsOfFile:" instead of "imageNamed:" here because we don't want UIImage to cache our tiles
    int scaleFactor = (int)(scale * 100);
    NSString *tilename = [NSString stringWithFormat:@"1930-%d-%d-%d", scaleFactor, col+1, row+1];
    NSLog(@"Tilename = %@", tilename);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:tilename ofType:@"png" inDirectory:@"1930pngs"];
    
    NSLog(@"Path = %@", path);
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}


@end
