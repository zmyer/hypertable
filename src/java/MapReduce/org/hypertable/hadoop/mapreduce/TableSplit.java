/**
 * Copyright (C) 2010 Doug Judd (Hypertable, Inc.)
 *
 * This file is part of Hypertable.
 *
 * Hypertable is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or any later version.
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

package org.hypertable.hadoop.mapreduce;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

import org.hypertable.hadoop.util.Serialization;

import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapreduce.InputSplit;

/**
 * A table split corresponds to a key range (low, high). All references to row
 * below refer to the key of the row.
 */
public class TableSplit extends InputSplit 
implements Writable, Comparable<TableSplit> {
  
  private byte [] m_tablename;
  private byte [] m_startrow;
  private byte [] m_endrow;
  private String m_range_location;

  /** Default constructor. */
  public TableSplit() {
      this(new byte [0], new byte [0], new byte [0], "");
  }

  /**
   * Creates a new instance while assigning all variables.
   * 
   * @param tableName  The name of the current table.
   * @param startRow  The start row of the split.
   * @param endRow  The end row of the split.
   * @param location  The location of the range.
   */
  public TableSplit(byte [] tableName, byte [] startRow, byte [] endRow,
      final String location) {
    this.m_tablename = tableName;
    this.m_startrow = startRow;
    this.m_endrow = endRow;
    this.m_range_location = location;
  }

  /**
   * Returns the table name.
   * 
   * @return The table name. 
   */
  public byte [] getTableName() {
    return m_tablename;
  }

  /**
   * Returns the start row.
   *  
   * @return The start row.
   */ 
  public byte [] getStartRow() {
    return m_startrow;
  }

  /**
   * Returns the end row.
   * 
   * @return The end row. 
   */
  public byte [] getEndRow() {
    return m_endrow;
  }

  /** 
   * Returns the range location.
   * 
   * @return The range's location. 
   */
  public String getRangeLocation() {
    return m_range_location;
  }

  /**
   * Returns the range's location as an array.
   * 
   * @return The array containing the range location.
   * @see org.apache.hadoop.mapreduce.InputSplit#getLocations()
   */
  @Override
  public String[] getLocations() {
    return new String[] {m_range_location};
  }

  /**
   * Returns the length of the split.
   * 
   * @return The length of the split.
   * @see org.apache.hadoop.mapreduce.InputSplit#getLength()
   */
  @Override
  public long getLength() {
    // Not clear how to obtain this... seems to be used only for sorting splits
    return 0;
  }

  /**
   * Reads the values of each field.
   * 
   * @param in  The input to read from.
   * @throws IOException When reading the input fails.
   */
  @Override
  public void readFields(DataInput in) throws IOException {
    m_tablename = Serialization.readByteArray(in);
    m_startrow = Serialization.readByteArray(in);
    m_endrow = Serialization.readByteArray(in);
    m_range_location = Serialization.toString(Serialization.readByteArray(in));
  }

  /**
   * Writes the field values to the output.
   * 
   * @param out  The output to write to.
   * @throws IOException When writing the values to the output fails.
   */
  @Override
  public void write(DataOutput out) throws IOException {
    Serialization.writeByteArray(out, m_tablename);
    Serialization.writeByteArray(out, m_startrow);
    Serialization.writeByteArray(out, m_endrow);
    Serialization.writeByteArray(out, Serialization.toBytes(m_range_location));
  }

  /**
   * Returns the details about this instance as a string.
   * 
   * @return The values of this instance as a string.
   * @see java.lang.Object#toString()
   */
  @Override
  public String toString() {
    return m_range_location + ":" +
      Serialization.toStringBinary(m_startrow) + "," + Serialization.toStringBinary(m_endrow);
  }

  /**
   * Compares this split against the given one.
   * 
   * @param split  The split to compare to.
   * @return The result of the comparison.
   * @see java.lang.Comparable#compareTo(java.lang.Object)
   */
  @Override
  public int compareTo(TableSplit split) {
    return Serialization.compareTo(getStartRow(), split.getStartRow());
  }
  
  @Override
  public boolean equals(Object o) {
    if (o == null || !(o instanceof TableSplit)) {
      return false;
    }
    return Serialization.equals(m_tablename, ((TableSplit)o).m_tablename) &&
      Serialization.equals(m_startrow, ((TableSplit)o).m_startrow) &&
      Serialization.equals(m_endrow, ((TableSplit)o).m_endrow) &&
      m_range_location.equals(((TableSplit)o).m_range_location);
  }
}
