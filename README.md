ZoomTest
========

This project is a minimal working implementation of CATiledLayer-based scrolling and zooming in UIScrollView.

It uses a subclass of UIView that returns a CATiledLayer to build a tiled map in the UIScrollView.  The map is comprised of 200x200 tiles created from the following image sizes:

- a base size of 500 x 870 (base file name of 1930-50-x-y.jpg)
- a x2 zoomed size of 1000 x 1740 (base filename of 1930-100-x-y.jpg)

The scrollView allows zoom scales of 0.25, 0.5, 1.0 and 2.0.  The default zoom scale is 0.5.