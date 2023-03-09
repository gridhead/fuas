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


# Output variables
# DO NOT MODIFY THE DEFAULT VALUE

lqnt, cmin, csec = 0, 0, 0
aqnt, rmin, rsec = 0, 0, 0

# Computing variables
# CHANGE THESE ONLY IF YOU KNOW WHAT YOU ARE DOING

totlqant = 0
userqant = 0
dfltsize = 1000

userlist = []

# Customizable variables
# CHANGE THESE TO SUIT YOUR NEEDS

daysqant = 90
pagerows = 1
minactqt = 5

services = ["pagure"]

jsonloca = "https://fasjson.fedoraproject.org"
useriden = "t0xic0der@FEDORAPROJECT.ORG"
listlink = "https://raw.githubusercontent.com/t0xic0der/fuas/main/data/namefile"
namefile = "/var/tmp/namefile"
actvfile = "/var/tmp/actvfile"
acqtfile = "/var/tmp/acqtfile"
dgprlink = "https://apps.fedoraproject.org/datagrepper/v2/search"
