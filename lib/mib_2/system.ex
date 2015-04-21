# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule MIB2.System do
  @oid_MIB_2_System "1.3.6.1.2.1.1"

  @oid_sysDescr    {"#{@oid_MIB_2_System}.1", :octet_string}
  @oid_sysObjectID {"#{@oid_MIB_2_System}.2", :object_identifier}
  @oid_sysUpTime   {"#{@oid_MIB_2_System}.3", :integer}
  @oid_sysContact  {"#{@oid_MIB_2_System}.4", :octet_string}
  @oid_sysName     {"#{@oid_MIB_2_System}.5", :octet_string}
  @oid_sysLocation {"#{@oid_MIB_2_System}.6", :octet_string}
  @oid_sysServices {"#{@oid_MIB_2_System}.7", :integer}

  def sysDescr do
    sysDescr("")
  end
  def sysDescr(value) when is_binary(value) do
    {oid, type} = @oid_sysDescr

    SNMPMIB.object(oid, type, value)
  end

  def sysObjectID do
    sysObjectID("")
  end
  def sysObjectID(value) do
    {oid, type} = @oid_sysObjectID

    SNMPMIB.object(oid, type, value)
  end

  def sysUpTime do
    sysUpTime("")
  end
  def sysUpTime(value) when is_binary(value) do
    {oid, type} = @oid_sysUpTime

    SNMPMIB.object(oid, type, value)
  end

  def sysContact do
    sysContact("")
  end
  def sysContact(value) when is_binary(value) do
    {oid, type} = @oid_sysContact

    SNMPMIB.object(oid, type, value)
  end

  def sysName do
    sysName("")
  end
  def sysName(value) when is_binary(value) do
    {oid, type} = @oid_sysName

    SNMPMIB.object(oid, type, value)
  end

  def sysLocation do
    sysLocation("")
  end
  def sysLocation(value) when is_binary(value) do
    {oid, type} = @oid_sysLocation

    SNMPMIB.object(oid, type, value)
  end

  def sysServices do
    sysServices("")
  end
  def sysServices(value) when is_binary(value) do
    {oid, type} = @oid_sysServices

    SNMPMIB.object(oid, type, value)
  end
end
