SmoothColor
===========

SmoothColor is a series of userstyles for Facebook coloring it in a variety of colors.
It is written in LESS, and compiled to CSS to be uploaded on Userstyles.org

The license is: Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)

As per the license for this theme (https://creativecommons.org/licenses/by-nc-sa/3.0/us/) you can share and remix this theme as you please for non-commercial purposes.
If you remix this theme, please link to the theme's page at userstyles.org (http://userstyles.org/styles/52576), and also link to my website in the theme's description (http://xvicario.us/).
Remix the userstyle using the uncompressed version (http://xvicario.us/SmoothRed-uncompressed.css), and keep the comments at the top intact.
If you use a CSS compresser, please host the uncompressed version elsewhere so you can continue to spread the love. If you have no place to host the userstyle, simply message me and I shall host it for you at my website.

---------
BUILD
---------

You will need the following to build this on Linux (Windows is supported through Cygwin or compatible systems, Mac may be supported yet not tested):

openssl -- to encode images as base64
lessc -- the less compiler

These should be available in your distro's repositories.  For ArchLinux, lessc is available in the AUR.

----------

To build:

./build <color> <debug>
Supported colors right now include: "red", "green", "purple"
Debug is 0/1 if you want to see the debug messages during the build (more support for this coming soon)


