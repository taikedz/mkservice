# mkservice

A tool for making systemd services easily

## Usage example

	mkservice -s SERVICENAME -d DESCRIPTION [OPTIONS ...] -- COMMAND ...

Creates a systemd service with the appropriate name, description and command.

Example for running an EtherpadLite instance (always restarts when the process exits):

	mkservice -s etherpad -d "Etherpad: a collaborative text editing tool" -u etherpad -- /home/etherpad/etherpad-lite/bin/run.sh

Example for running a Minetest game server instance (only restarts on error - if the admin shuts down from within the game [not an error], the service stops too):

	mkservice -s minetest -d "Minetest world1 server" -u minetest -r on-failure -- /home/minetest/mt-runner

See the [help file](src/help.sh) for a list of options.

## Building the tool

This project is written in bash, and uses [Bash Builder](https://github.com/taikedz/bash-builder) to build the runnable script.

Individual source files are in `src/`

This project depends on common libraries provided by Bash Builder.

**Build**

From the project root (where this README resides), simply run

	bbuild

And this should build this project to the `bin/` directory.
