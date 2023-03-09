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


# ==== ==== ==== ==== ==== ==== ==== ====

# Output variables
# DO NOT MODIFY THE DEFAULT VALUE

lqnt, cmin, csec = 0, 0, 0
aqnt, rmin, rsec = 0, 0, 0

# ==== ==== ==== ==== ==== ==== ==== ====

# Computing variables
# CHANGE THESE ONLY IF YOU KNOW WHAT YOU ARE DOING

# ==== ==== ==== ==== ==== ==== ==== ====

# Size of iterable pages for all entities present in the FASJSON service
# Default 1000
dfltsize = 1000

# ==== ==== ==== ==== ==== ==== ==== ====

# Customizable variables
# CHANGE THESE TO SUIT YOUR NEEDS

# ==== ==== ==== ==== ==== ==== ==== ====

# Number of days for which the activity record is requested for
# Defalt 90
daysqant = 90

# Number of rows to be displayed on a page when requesting data from Datagrepper
# Default 1
pagerows = 1

# Minimum number of activities to be considered to count as user as "active"
# Default 5
minactqt = 5

# Services to probe into for activity records pertaining to the users
# Default ["pagure"]
services = ["pagure"]

# Location where the FASJSON service is hosted
# Default "https://fasjson.fedoraproject.org"
jsonloca = "https://fasjson.fedoraproject.org"

# Location where the Datagrepper service is hosted
# Default "https://apps.fedoraproject.org/datagrepper/v2/search"
dgprlink = "https://apps.fedoraproject.org/datagrepper/v2/search"

# User to masquerade as for probing into the FASJSON records
# Default "t0xic0der@FEDORAPROJECT.ORG"
useriden = "t0xic0der@FEDORAPROJECT.ORG"

# Location where the list of available users is present
# Default "https://raw.githubusercontent.com/t0xic0der/fuas/main/data/namefile"
listlink = "https://raw.githubusercontent.com/t0xic0der/fuas/main/data/namefile"

# Location where the list of available users is to be stored locally
# Default "/var/tmp/namefile"
namefile = "/var/tmp/namefile"

# Location where the list of active users is to be stored locally
# Default "/var/tmp/actvfile"
actvfile = "/var/tmp/actvfile"

# Location where the count of active users is to be stored locally
# Default "/var/tmp/acqtfile"
acqtfile = "/var/tmp/acqtfile"
