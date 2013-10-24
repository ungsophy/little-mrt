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
