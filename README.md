## Overview

`VFSContainerView` is a `UIView` subclass that supports selective `userInteractionEnabled`. It can be told to ignore touches outside of its subviews by setting `userInteractionOutsideSubviewsEnabled` to `NO`.

### What's the point?

This is useful in situations where you want a container view for layout only, and views behind the container still need to receive touches. `[UIView userInteractionEnabled]` will do something similar, but using this property also blocks touches from reaching any of the subviews of your container view.

### How does it work?

`VFSContainerView` overrides `[UIView pointInside:withEvent:]` and returns `NO` when the point falls outside of its subviews. The responder chain then sends the touch through to the superview.

## Installation

Installation is best done via [cocoapods](http://cocoapods.org).

### Podfile

    pod 'VFSContainerView'
    
## Usage

Just use `VFSContainerView` like you would any other container view. `userInteractionOutsideSubviewsEnabled` is the property it adds, which is `NO` by default. So the default behaviour on allocation is to ignore touches outside subviews and forward them onto the superview.

## Testing

There are some tests, but they're probably rubbish. Feel free to open pull requests with improvements.