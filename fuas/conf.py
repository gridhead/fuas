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


from fasjson_client import Client

jsonloca = "https://fasjson.fedoraproject.org"
useriden = "t0xic0der@FEDORAPROJECT.ORG"

optnlist = ["frge", "srce"]

totlqant = 0
dfltsize = 1000
namefile = "/var/tmp/namefile"

cobj = Client(jsonloca, principal=useriden)
