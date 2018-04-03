# mkservice

A tool for making systemd services easily

## Install

Installing `mkservice` is easy - clone the repository and run the install script. Or more completely, do it from a [tagged release](https://github.com/taikedz/mkservice/releases)

	git clone https://github.com/taikedz/mkservice
	cd mkservice
	git checkout 1.0.1
	sudo ./install.sh

## Usage example

	mkservice -s SERVICENAME -d DESCRIPTION [OPTIONS ...] -- COMMAND ...

Creates a systemd service with the appropriate name, description and command.

Example for running an EtherpadLite instance (always restarts when the process exits):

	mkservice -s etherpad -d "Etherpad: a collaborative text editing tool" -u etherpad -- /home/etherpad/etherpad-lite/bin/run.sh

Example for running a Minetest game server instance (only restarts on error - if the admin shuts down from within the game [not an error], the service stops too):

	mkservice -s minetest -d "Minetest world1 server" -u minetest -r on-failure -- /home/minetest/mt-runner

See the [help file](src/help.sh) for a list of options.

## Building the tool

This project is written in bash, and uses [Bash Builder](https://github.com/taikedz/bash-builder) to build the runnable script. (current version built with bbuild 5.1)

Individual source files are in `src/`

This project depends on common libraries provided by Bash Builder.

**Build**

From the project root (where this README resides), simply run

	bbuild

And this should build this project to the `bin/` directory.

**Contributing**

Contributions are welcome, please keep in mind to write clean code (bash does not inevitably mean blob scripting!).

Please be mindful not to include the `bbversion/*` and `bin/*` files in commits that will be pull-requested.
