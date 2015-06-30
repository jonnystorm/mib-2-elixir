# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule MIB2.IP.IPNetToMediaTable do
  @oid_MIB_2_ip_ipNetToMediaTable "1.3.6.1.2.1.4.22"

  def oid do
    @oid_MIB_2_ip_ipNetToMediaTable
  end

  defp get_key_by_value(dict, value) do
    {k, _} = dict |> Enum.find(fn {_k, v} -> v == value end)

    k
  end 

  # Convenience types: not part of MIB
  @type ipNetToMediaType :: 1..4
  def typeIpNetToMediaType do
    %{
      other: 1,
      invalid: 2,
      dynamic: 3,
      static: 4
    }
  end
  def typeIpNetToMediaType(value) when is_atom(value) do
    typeIpNetToMediaType[value]
  end
  def typeIpNetToMediaType(value) when is_integer(value) do
    get_key_by_value(typeIpNetToMediaType, value)
  end

  defmodule IPNetToMediaEntry do
    alias MIB2.IP.IPNetToMediaTable

    @oid_ipNetToMediaEntry "1.3.6.1.2.1.4.22.1"

    @oid_ipNetToMediaIfIndex        {"#{@oid_ipNetToMediaEntry}.1", :integer}
    @oid_ipNetToMediaPhysAddress    {"#{@oid_ipNetToMediaEntry}.2", :string}
    @oid_ipNetToMediaNetAddress     {"#{@oid_ipNetToMediaEntry}.3", :string}
    @oid_ipNetToMediaType           {"#{@oid_ipNetToMediaEntry}.4", :integer}

    defstruct [
      ipNetToMediaIfIndex: nil,
      ipNetToMediaPhysAddress: nil,
      ipNetToMediaNetAddress: nil,
      ipNetToMediaType: nil
    ]

    @type t :: %IPNetToMediaEntry{
      ipNetToMediaIfIndex: integer,
      ipNetToMediaPhysAddress: String.t,
      ipNetToMediaNetAddress: String.t,
      ipNetToMediaType: IPNetToMediaTable.ipNetToMediaType
    }

    def ipNetToMediaIfIndex do
      ipNetToMediaIfIndex(%IPNetToMediaEntry{})
    end
    def ipNetToMediaIfIndex(ipNetToMediaEntry) do
      {oid, type} = @oid_ipNetToMediaIfIndex

      SNMPMIB.object(oid, type, ipNetToMediaEntry.ipNetToMediaIfIndex)
    end
    def ipNetToMediaIfIndex(ipNetToMediaEntry, value) do
      %IPNetToMediaEntry{ipNetToMediaEntry|ipNetToMediaIfIndex: value}
    end

    def ipNetToMediaPhysAddress do
      ipNetToMediaPhysAddress(%IPNetToMediaEntry{})
    end
    def ipNetToMediaPhysAddress(ipNetToMediaEntry) do
      {oid, type} = @oid_ipNetToMediaPhysAddress

      SNMPMIB.object(oid, type, ipNetToMediaEntry.ipNetToMediaPhysAddress)
    end
    def ipNetToMediaPhysAddress(ipNetToMediaEntry, value) do
      %IPNetToMediaEntry{ipNetToMediaEntry|ipNetToMediaPhysAddress: value}
    end

    def ipNetToMediaNetAddress do
      ipNetToMediaNetAddress(%IPNetToMediaEntry{})
    end
    def ipNetToMediaNetAddress(ipNetToMediaEntry) do
      {oid, type} = @oid_ipNetToMediaNetAddress

      SNMPMIB.object(oid, type, ipNetToMediaEntry.ipNetToMediaNetAddress)
    end
    def ipNetToMediaNetAddress(ipNetToMediaEntry, value) do
      %IPNetToMediaEntry{ipNetToMediaEntry|ipNetToMediaNetAddress: value}
    end

    def ipNetToMediaType do
      ipNetToMediaType(%IPNetToMediaEntry{})
    end
    def ipNetToMediaType(ipNetToMediaEntry) do
      {oid, type} = @oid_ipNetToMediaType

      SNMPMIB.object(oid, type, ipNetToMediaEntry.ipNetToMediaType)
    end
    def ipNetToMediaType(ipNetToMediaEntry, value) do
      value = CiscoConfigCopy.typeIpNetToMediaType |> Map.fetch!(value)

      %IPNetToMediaEntry{ipNetToMediaEntry|ipNetToMediaType: value}
    end
  end

  @spec ip_net_to_media_entry(integer, String.t, String.t, ipNetToMediaType) :: IPNetToMediaEntry.t
  def ip_net_to_media_entry(if_index, network_address, physical_address, type) do
    %IPNetToMediaEntry{}
    |> IPNetToMediaEntry.ipNetToMediaIfIndex(if_index)
    |> IPNetToMediaEntry.ipNetToMediaPhysAddress(physical_address)
    |> IPNetToMediaEntry.ipNetToMediaNetAddress(network_address)
    |> IPNetToMediaEntry.ipNetToMediaType(type)
  end
end

