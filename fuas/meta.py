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


import os
import time

from fuas import conf


def getquant():
    resp = conf.cobj.list_users(page_size=1).page
    return resp["total_results"]


def keepname():
    strt = time.time()
    lqnt = 0
    if os.path.isfile(conf.namefile):
        os.remove(conf.namefile)
    with open(conf.namefile, "a") as file:
        nmls = []
        resp = conf.cobj.list_users(page_size=conf.dfltsize)
        rslt = resp.result
        for indx in rslt:
            nmls.append(indx["username"])
            lqnt += 1
        file.write("\n".join(nmls) + "\n")
        iter = (conf.totlqant // conf.dfltsize) - 1
        for indx in range(iter):
            rslt = resp.next_page().result
            nmls = []
            for indx in rslt:
                nmls.append(indx["username"])
                lqnt += 1
            file.write("\n".join(nmls) + "\n")
    fnsh = time.time()
    totl = fnsh - strt
    print("%d usernames stored in %d minutes and %d seconds" % (lqnt, totl // 60, totl % 60))
