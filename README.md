Little MRT
==========

This is the graph that represents a railroad in a little town. All of the tracks are 'one-way.'  That is, a route from **A** to **B** does not imply the existence of a route from **B** to **A**.  In fact, even if both of these routes do happen to exist, they are distinct and are not necessarily the same distance.

For example, in the graph below, there is a route from **A** to **B**, but there is no route from **B** to **A**. There is also a route from **C** to **D** and vice versa. The number next to line indicate the distance between stations.

![Little MRT graph](https://raw.github.com/ungsophy/little-mrt/master/little_mrt_graph.jpg)

## Data

In order for this program to work it needs data which is located at [```little-mrt/lib/data.yml```](https://github.com/ungsophy/little-mrt/blob/master/lib/data.yml). [```little-mrt/lib/data.yml```](https://github.com/ungsophy/little-mrt/blob/master/lib/data.yml) contains stations and adjacency matrix. A adjacency must has from and to station and distance between the stations.

## Usage

Add this to your Gemfile

```
gem 'little-mrt', git: 'git@github.com:ungsophy/little-mrt.git'
```

A simple example:

```ruby
require 'little-mrt'

graph = LittleMRT::Graph.new
paths = graph.search('A-B-C')  
paths.first.distance           # 9 
paths.first.to_s               # 'A-B-C'
```
It looks like ```LittleMRT::Graph#search``` returns an array of paths. Yes you're right, but it's more than just a regular array. It returns ```LittleMRT::Paths``` object that wrapped array of paths and added a couple more useful filter methods into it. You will see it next.

```ruby
paths = graph.search('A-C')    # It retuns all possible paths from A to C
                               # A-B-C, A-D-C, A-D-E-B-C and A-E-B-C

paths.min_distance             # It returns LittleMRT::Path that has the shortest distance 
                               # which is A-B-C
                               
paths = graph.search('C-C')    # It retuns all possible paths from C to C
                               # C-D-C, C-D-E-B-C and C-E-B-C
                               
paths.max_stop(3)              # It returns a new LittleMRT::Paths object 
                               # that have paths that have no more than 3 stops.
                               # C-D-C and C-E-B-C
```

## How to run tests

This program requires Ruby 1.9+

To run test:

```
$ cd little-mrt
$ bundle install
$ rake
```

## License

See [```LICENSE```](https://raw.github.com/ungsophy/little-mrt/master/LICENSE) file.
