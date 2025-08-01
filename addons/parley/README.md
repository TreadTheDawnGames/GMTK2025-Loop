# Parley

![parley-icon](./icon.png)

Parley is an addon for [Godot 4.4+](https://godotengine.org/) that provides a
graph-based dialogue manager for easy writing, testing, and running of Dialogue
Sequences at scale and is designed to be used by game writers and developers
alike.

Write your Dialogue Sequences by defining the graph for your Dialogue Sequence
which are backed by a well-defined Dialogue AST for easy management and
integration within your game.

You can install it via the
[Asset Library](https://godotengine.org/asset-library/asset/4132) or
[downloading a copy](https://github.com/bisterix-studio/parley/archive/refs/heads/main.zip)
from GitHub.

[![GitHub Licence](https://img.shields.io/github/license/bisterix-studio/parley?style=flat-square)](https://raw.githubusercontent.com/bisterix-studio/parley/main/LICENSE)
[![Buy us a tree](https://img.shields.io/badge/Treeware-%F0%9F%8C%B3-lightgreen)](https://plant.treeware.earth/bisterix-studio/parley)

![Example usage of Parley](https://parley.bisterixstudio.com/illustration/parley-graph-view.gif)

## Table of contents

- [Features](#features)
- [Upcoming Features](#upcoming-features)
- [Installation](#installation)
- [Documentation](#documentation)
- [Support](#support)
- [Known Issues and Troubleshooting](#known-issues-and-troubleshooting)
- [Licence](#licence)
- [Contributions](#contributions)

Installation Features Examples Support Useful links Licence Contributions

## Features

- An easy-to-use and well-defined Graph Editor
- A wide variety of Nodes for maximum flexibility and creativity:
  - [Dialogue](https://parley.bisterixstudio.com/docs/nodes/dialogue-node)
  - [Dialogue Option](https://parley.bisterixstudio.com/docs/nodes/dialogue-option-node)
  - [Condition](https://parley.bisterixstudio.com/docs/nodes/condition-node)
  - [Match](https://parley.bisterixstudio.com/docs/nodes/match-node)
  - [Action](https://parley.bisterixstudio.com/docs/nodes/action-node)
  - [Jump](https://parley.bisterixstudio.com/docs/nodes/jump-node)
  - [Group](https://parley.bisterixstudio.com/docs/nodes/group-node)
  - [Start](https://parley.bisterixstudio.com/docs/nodes/start-node)
  - [End](https://parley.bisterixstudio.com/docs/nodes/end-node)
- Creation of connections between Nodes to easily see the flow of your dialogue
  sequence
- Easy testing of your dialogue at any stage in the sequence
- Well-defined Dialogue AST for easy review and management of Dialogue Sequences
- Character store for management of characters in Dialogue and Dialogue Options
- Action store for management of actions for use with Action nodes
- Fact store for management of facts for use with Condition and Match nodes
- An out of the box dialogue balloon to get started straight away
- Easy management of your Dialogue Sequences, including Node filtering
- Export your Dialogue passages to CSV

## Upcoming Features

Here are some key features on the Parley horizon. We are always open to new
ideas, please don't hesitate to
[get-in-touch](https://github.com/bisterix-studio/parley/issues).

- Translation support
- Dialogue text expressions

## Installation

You can install it via the Asset Library or
[downloading a copy](https://github.com/bisterix-studio/parley/archive/refs/heads/main.zip)
from GitHub.

Once installed, please following the guide for first-time setup.

[Installation Guide](https://parley.bisterixstudio.com/docs/getting-started/installation)

## Documentation

Documentation for Parley can be found
[here](https://parley.bisterixstudio.com/docs).

## Support

| Version  | Supported	Godot version |
| -------- | ----------------------- |
| `latest` | `4.4+`                  |

## Known Issues and Troubleshooting

### Parts of Godot are unresponsive in MacOS after close a test dialogue scene via the close button

**Solution:** Swipe up with three fingers to open Mission Control. Swipe down
again to make Godot responsive again. Currently not sure why it happens, please
submit an issue if you have any further data on this issue.

## Licence

Parley is 100% free and open-source, under the MIT licence.
[The license is distributed with Parley and can be found in the `addons/parley` folder](https://github.com/bisterix-studio/parley/blob/main/addons/parley/LICENSE).

This package is [Treeware](https://treeware.earth). If you use it in production,
then we ask that you
[**buy the world a tree**](https://plant.treeware.earth/bisterix-studio/parley)
to thank us for our work. By contributing to the Treeware forest you’ll be
creating employment for local families and restoring wildlife habitats.

## Contributions

[Contributions](https://github.com/bisterix-studio/parley/blob/main/CONTRIBUTING.md),
issues and feature requests are very welcome. If you are using this package and
fixed a bug for yourself, please consider submitting a PR!

<p align="center">
  <a href="https://github.com/bisterix-studio/parley/graphs/contributors">
	<img src="https://contrib.rocks/image?repo=bisterix-studio/parley&columns=8" />
  </a>
</p>
