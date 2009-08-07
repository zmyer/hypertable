/** -*- c++ -*-
 * Copyright (C) 2008 Luke Lu (Zvents, Inc.)
 *
 * This file is part of Hypertable.
 *
 * Hypertable is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of the
 * License, or any later version.
 *
 * Hypertable is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 */

#include "Common/Compat.h"
#include <iostream>
#include "Common/Init.h"
#include "Common/Thread.h"
#include "Common/System.h"
#include "Common/Logger.h"
#include "Common/Error.h"
#include "Hypertable/Lib/Config.h"
#include "Hypertable/Lib/Client.h"
#include "DfsBroker/Lib/Client.h"
#include "MasterGc.h"

using namespace Hypertable;
using namespace Config;

namespace {

struct MyPolicy : Config::Policy {
  static void init_options() {
    cmdline_desc().add_options()
      ("dryrun,n", "Dryrun, don't modify (delete files etc.)")
      ("full", "Do a full scan of DFS files and compare with METADATA.")
      ;
  }
};

typedef Cons<MyPolicy, DefaultCommPolicy> AppPolicy;

void
do_tfgc(bool dryrun, bool full) {
  ConnectionManagerPtr conn_mgr = new ConnectionManager();
  DfsBroker::Client *fs = new DfsBroker::Client(conn_mgr, properties);
  ClientPtr client = new Hypertable::Client("htgc");
  TablePtr table = client->open_table("METADATA");
  master_gc_once(table, fs, dryrun);
}

} // local namespace

int
main(int ac, char *av[]) {
  try {
    init_with_policy<AppPolicy>(ac, av);
    do_tfgc(has("dryrun"), has("full"));
  }
  catch (Exception &e) {
    HT_ERROR_OUT << e << HT_END;
    return 1;
  }
  return 0;
}
