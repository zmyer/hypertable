/* -*- c++ -*-
 * Copyright (C) 2007-2016 Hypertable, Inc.
 *
 * This file is part of Hypertable.
 *
 * Hypertable is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 3 of the
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

/** @file
 * Definitions for MetaLog::EntityHeader.
 * This file contains definitions for MetaLog::EntityHeader, a class used to
 * encode and decode a %MetaLog entity header.
 */

#include <Common/Compat.h>

#include "MetaLogEntity.h"

#include <Common/Serialization.h>
#include <Common/Time.h>

#include <ctime>
#include <string>

using namespace Hypertable;
using namespace Hypertable::MetaLog;
using namespace std;

int64_t EntityHeader::ms_next_id = 1;
std::mutex EntityHeader::ms_mutex;
bool EntityHeader::display_timestamp = true;


EntityHeader::EntityHeader() { }

EntityHeader::EntityHeader(int32_t type_) : type(type_) {
  {
    lock_guard<mutex> lock(ms_mutex);
    id = ms_next_id++;
  }
  timestamp = get_ts64();
}

EntityHeader::EntityHeader(const EntityHeader &other) {
  type = other.type;
  checksum = other.checksum;
  length = other.length;
  id = other.id;
  timestamp = other.timestamp;
  flags = other.flags;
  {
    lock_guard<mutex> lock(ms_mutex);
    if (ms_next_id <= other.id)
      ms_next_id = other.id + 1;
  }
}

bool EntityHeader::operator<(const EntityHeader &other) const {
  if (id == other.id)
    return false;
  else if (timestamp < other.timestamp)
    return true;
  else if (timestamp == other.timestamp && id < other.id)
    return true;
  return false;
}


void EntityHeader::encode(uint8_t **bufp) const {
  Serialization::encode_i32(bufp, type);
  Serialization::encode_i32(bufp, checksum);
  Serialization::encode_i32(bufp, length);
  Serialization::encode_i32(bufp, flags);
  Serialization::encode_i64(bufp, id);
  Serialization::encode_i64(bufp, timestamp);
}

void EntityHeader::decode(const uint8_t **bufp, size_t *remainp) {
  type      = Serialization::decode_i32(bufp, remainp);
  checksum  = Serialization::decode_i32(bufp, remainp);
  length    = Serialization::decode_i32(bufp, remainp);
  flags     = Serialization::decode_i32(bufp, remainp);
  id        = Serialization::decode_i64(bufp, remainp);
  timestamp = Serialization::decode_i64(bufp, remainp);
}


void EntityHeader::display(std::ostream &os) {
  os << "type=" << type;
  os << ",checksum=" << checksum;
  os << ",id=" << id;
  if (display_timestamp) {
    time_t t = (time_t)(timestamp / 1000000000LL);
    char buf[32];
    struct tm tmval;
    string timestr(asctime_r(gmtime_r(&t, &tmval), buf));
    boost::trim_if(timestr, boost::is_any_of(" \t\n"));
    os << ",timestamp=" << timestr;
  }
  os << ",flags=" << flags;
  os << ",length=" << length;
}
