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


import os
import time

import requests
from fasjson_client import Client

from fuas import conf


def keepname():
    strt = time.time()
    lqnt = 0
    cobj = Client(conf.jsonloca, principal=conf.useriden)
    if os.path.isfile(conf.namefile):
        os.remove(conf.namefile)
    with open(conf.namefile, "a") as file:
        for user in cobj.list_all_entities("users", page_size=conf.dfltsize):
            lqnt += 1
            file.write(f"{user['username']}\n")
    fnsh = time.time()
    totl = fnsh - strt
    conf.lqnt, conf.cmin, conf.csec = lqnt, totl // 60, totl % 60


def readlist():
    userlist = requests.get(conf.listlink).text.split("\n")
    userlist.remove("")
    return userlist


def keepactv():
    strt = time.time()
    aqnt = 0
    if os.path.isfile(conf.actvfile):
        os.remove(conf.actvfile)
    with open(conf.actvfile, "a") as file:
        userlist = readlist()
        for username in userlist:
            response = requests.get(
                conf.dgprlink,
                params={
                    "user": username,
                    "delta": conf.daysqant * 24 * 60 * 60,
                    "category": conf.services,
                    "rows_per_page": conf.pagerows,
                },
            )
            if response.ok:
                respqant = response.json()["total"]
                if respqant >= conf.minactqt:
                    aqnt += 1
                    file.write(f"{username}\n")
    if os.path.isfile(conf.acqtfile):
        os.remove(conf.acqtfile)
    with open(conf.acqtfile, "w") as file:
        file.write(str(aqnt))
    fnsh = time.time()
    totl = fnsh - strt
    conf.aqnt, conf.rmin, conf.rsec = aqnt, totl // 60, totl % 60
