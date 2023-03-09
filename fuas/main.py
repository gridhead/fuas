"""
Fedora User Activity Statistics
Copyright (C) 2023 Akashdeep Dhar

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
from fuas.meta import getquant, keepactv, keepname, readlist


@click.group(name="fuas")
@click.version_option(version=__version__, prog_name="fuas")
def main():
    pass


@main.command(name="namelist", help="Fetch a list of usernames on the Fedora Account System")
def namelist():
    conf.totlqant = getquant()
    keepname()
    print("%d usernames fetched in %d minutes and %d seconds" % (conf.lqnt, conf.cmin, conf.csec))


@main.command(name="activity", help="Fetch a list of active usernames from Datagrepper")
def activity():
    conf.userqant, conf.userlist = readlist()
    keepactv()
    print("%d active users found in %d minutes and %d seconds" % (conf.aqnt, conf.rmin, conf.rsec))
