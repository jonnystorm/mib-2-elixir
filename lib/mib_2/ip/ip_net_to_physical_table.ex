# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule MIB2.IP.IPNetToPhysicalTable do
  @oid_MIB_2_ip "1.3.6.1.2.1.4"

  defp get_key_by_value(dict, value) do
    dict
      |> Enum.find(fn {_k, v} -> v == value end)
      |> (fn {k, _v} -> k end).()
  end 

  @type inetAddressType :: 0..4 | 16
  def typeInetAddressType do
    %{
      unknown: 0,
      ipv4:    1,
      ipv6:    2,
      ipv4z:   3,
      ipv6z:   4,
      dns:    16
    }
  end
  def typeInetAddressType(value) when is_atom(value) do
    typeInetAddressType[value]
  end
  def typeInetAddressType(value) when is_integer(value) do
    get_key_by_value(typeInetAddressType, value)
  end

  @type rowStatus :: 1..6
  def typeRowStatus do
    %{
      active: 1,
      not_in_service: 2,
      not_ready: 3,
      create_and_go: 4,
      create_and_wait: 5,
      destroy: 6
    }
  end
  def typeRowStatus(value) when is_atom(value) do
    typeRowStatus[value]
  end
  def typeRowStatus(value) when is_integer(value) do
    get_key_by_value(typeRowStatus, value)
  end

  # Convenience types: not part of MIB
  @type ipNetToPhysicalType :: 1..5
  def typeIpNetToPhysicalType do
    %{
      other: 1,
      invalid: 2,
      dynamic: 3,
      static: 4,
      local: 5
    }
  end
  def typeIpNetToPhysicalType(value) when is_atom(value) do
    typeIpNetToPhysicalType[value]
  end
  def typeIpNetToPhysicalType(value) when is_integer(value) do
    get_key_by_value(typeIpNetToPhysicalType, value)
  end

  @type ipNetToPhysicalState :: 1..7
  def typeIpNetToPhysicalState do
    %{
      reachable: 1,
      stale: 2,
      delay: 3,
      probe: 4,
      invalid: 5,
      unknown: 6,
      incomplete: 7
    }
  end
  def typeIpNetToPhysicalState(value) when is_atom(value) do
    typeIpNetToPhysicalState[value]
  end
  def typeIpNetToPhysicalState(value) when is_integer(value) do
    get_key_by_value(typeIpNetToPhysicalState, value)
  end

  defmodule IPNetToPhysicalEntry do
    alias MIB2.IP.IPNetToPhysicalTable

    @oid_ipNetToPhysicalEntry "1.3.6.1.2.1.4.35.1"

    @oid_ipNetToPhysicalIndex          {"#{@oid_ipNetToPhysicalEntry}.1", :integer}
    @oid_ipNetToPhysicalNetAddressType {"#{@oid_ipNetToPhysicalEntry}.2", :integer}
    @oid_ipNetToPhysicalNetAddress     {"#{@oid_ipNetToPhysicalEntry}.3", :string}
    @oid_ipNetToPhysicalPhysAddress    {"#{@oid_ipNetToPhysicalEntry}.4", :string}
    @oid_ipNetToPhysicalLastUpdated    {"#{@oid_ipNetToPhysicalEntry}.5", :string}
    @oid_ipNetToPhysicalType           {"#{@oid_ipNetToPhysicalEntry}.6", :integer}
    @oid_ipNetToPhysicalState          {"#{@oid_ipNetToPhysicalEntry}.7", :integer}
    @oid_ipNetToPhysicalRowStatus      {"#{@oid_ipNetToPhysicalEntry}.8", :integer}

    defstruct [
      ipNetToPhysicalIndex: nil,
      ipNetToPhysicalNetAddressType: nil,
      ipNetToPhysicalNetAddress: nil,
      ipNetToPhysicalPhysAddress: nil,
      ipNetToPhysicalLastUpdated: nil,
      ipNetToPhysicalType: nil,
      ipNetToPhysicalState: nil,
      ipNetToPhysicalRowStatus: nil
    ]

    @type t :: %IPNetToPhysicalEntry{
      ipNetToPhysicalIndex: integer,
      ipNetToPhysicalNetAddressType: IPNetToPhysicalTable.inetAddressType,
      ipNetToPhysicalNetAddress: String.t,
      ipNetToPhysicalPhysAddress: String.t,
      ipNetToPhysicalLastUpdated: String.t,
      ipNetToPhysicalType: IPNetToPhysicalTable.ipNetToPhysicalType,
      ipNetToPhysicalState: IPNetToPhysicalTable.ipNetToPhysicalState,
      ipNetToPhysicalRowStatus: IPNetToPhysicalTable.rowStatus
    }

    def ipNetToPhysicalIndex do
      ipNetToPhysicalIndex(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalIndex(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalIndex

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalIndex)
    end
    def ipNetToPhysicalIndex(ipNetToPhysicalEntry, value) do
      %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalIndex: value}
    end

    def ipNetToPhysicalNetAddressType do
      ipNetToPhysicalNetAddressType(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalNetAddressType(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalNetAddressType

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalNetAddressType)
    end
    def ipNetToPhysicalNetAddressType(ipNetToPhysicalEntry, value) do
      CiscoConfigCopy.typeIpNetToPhysicalNetAddressType
      |> Map.fetch!(value)
      |> (&( %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalNetAddressType: &1} )).()
    end

    def ipNetToPhysicalNetAddress do
      ipNetToPhysicalNetAddress(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalNetAddress(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalNetAddress

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalNetAddress)
    end
    def ipNetToPhysicalNetAddress(ipNetToPhysicalEntry, value) do
      %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalNetAddress: value}
    end

    def ipNetToPhysicalPhysAddress do
      ipNetToPhysicalPhysAddress(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalPhysAddress(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalPhysAddress

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalPhysAddress)
    end
    def ipNetToPhysicalPhysAddress(ipNetToPhysicalEntry, value) do
      %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalPhysAddress: value}
    end

    def ipNetToPhysicalLastUpdated do
      ipNetToPhysicalLastUpdated(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalLastUpdated(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalLastUpdated

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalLastUpdated)
    end
    def ipNetToPhysicalLastUpdated(ipNetToPhysicalEntry, value) do
      %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalLastUpdated: value}
    end

    def ipNetToPhysicalType do
      ipNetToPhysicalType(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalType(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalType

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalType)
    end
    def ipNetToPhysicalType(ipNetToPhysicalEntry, value) do
      CiscoConfigCopy.typeIpNetToPhysicalType
      |> Map.fetch!(value)
      |> (&( %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalType: &1} )).()
    end

    def ipNetToPhysicalState do
      ipNetToPhysicalState(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalState(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalState

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalState)
    end
    def ipNetToPhysicalState(ipNetToPhysicalEntry, value) do
      CiscoConfigCopy.typeIpNetToPhysicalState
      |> Map.fetch!(value)
      |> (&( %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalState: &1} )).()
    end

    def ipNetToPhysicalRowStatus do
      ipNetToPhysicalRowStatus(%IPNetToPhysicalEntry{})
    end
    def ipNetToPhysicalRowStatus(ipNetToPhysicalEntry) do
      {oid, type} = @oid_ipNetToPhysicalRowStatus

      SNMPMIB.object(oid, type, ipNetToPhysicalEntry.ipNetToPhysicalRowStatus)
    end
    def ipNetToPhysicalRowStatus(ipNetToPhysicalEntry, value) do
      CiscoConfigCopy.typeIpNetToPhysicalRowStatus
      |> Map.fetch!(value)
      |> (&( %IPNetToPhysicalEntry{ipNetToPhysicalEntry|ipNetToPhysicalRowStatus: &1} )).()
    end
  end

  @spec ip_net_to_physical_entry(integer,
      inetAddressType, String.t, String.t,
      String.t, ipNetToPhysicalType, ipNetToPhysicalState, rowStatus) :: IPNetToPhysicalEntry.t
  def ip_net_to_physical_entry(index,
      network_address_type, network_address, physical_address,
      last_updated, type, state, row_status) do
    %IPNetToPhysicalEntry{}
      |> IPNetToPhysicalEntry.ipNetToPhysicalIndex(index)
      |> IPNetToPhysicalEntry.ipNetToPhysicalNetAddressType(network_address_type)
      |> IPNetToPhysicalEntry.ipNetToPhysicalNetAddress(network_address)
      |> IPNetToPhysicalEntry.ipNetToPhysicalPhysAddress(physical_address)
      |> IPNetToPhysicalEntry.ipNetToPhysicalLastUpdated(last_updated)
      |> IPNetToPhysicalEntry.ipNetToPhysicalType(type)
      |> IPNetToPhysicalEntry.ipNetToPhysicalState(state)
      |> IPNetToPhysicalEntry.ipNetToPhysicalRowStatus(row_status)
  end
end

