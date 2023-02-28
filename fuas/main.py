"""
Fedora User Activity
Copyright (C) 2022 Akashdeep Dhar

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""


import click

from fuas import __version__, conf
from fuas.meta import getquant, keepname


@click.group(name="fuas")
@click.version_option(version=__version__, prog_name="fuas")
def main():
    conf.totlqant = getquant()


@main.command(
    name="namelist", help="Fetch a list of usernames registered on the Fedora Account System"
)
def namelist():
    keepname()
