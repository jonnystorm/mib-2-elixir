# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule MIB2.IP.IPRouteTable do
  @oid_MIB_2_ip_ipRouteTable "1.3.6.1.2.1.4.21"

  def oid do
    @oid_MIB_2_ip_ipRouteTable
  end

  defp get_key_by_value(dict, value) do
    {k, _} = dict |> Enum.find(fn {_k, v} -> v == value end)

    k
  end 

  # Convenience types: not part of MIB
  @type ipRouteType :: 1..4
  def typeIpRouteType do
    %{
      other:  1,
      invalid: 2,
      direct:  3,
      indirect: 4
    }
  end
  def typeIpRouteType(value) when is_atom(value) do
    typeIpRouteType[value]
  end
  def typeIpRouteType(value) when is_integer(value) do
    get_key_by_value(typeIpRouteType, value)
  end

  @type ipRouteProto :: 1..16
  def typeIpRouteProto do
    %{
      other:       1,
      local:       2,
      netmgmt:     3,
      icmp:        4,
      egp:         5,
      ggp:         6,
      hello:       7,
      rip:         8,
      is_is:       9,
      es_is:      10,
      ciscoIgrp:  11,
      bbnSpfIgp:  12,
      ospf:       13,
      bgp:        14,
      idpr:       15,
      ciscoEigrp: 16
    }
  end
  def typeIpRouteProto(value) when is_atom(value) do
    typeIpRouteProto[value]
  end
  def typeIpRouteProto(value) when is_integer(value) do
    get_key_by_value(typeIpRouteProto, value)
  end

  defmodule IPRouteEntry do
    alias MIB2.IP.IPRouteTable

    @oid_ipRouteEntry "1.3.6.1.2.1.4.21.1"

    @oid_ipRouteDest      {"#{@oid_ipRouteEntry}.1",  :string}
    @oid_ipRouteIfIndex   {"#{@oid_ipRouteEntry}.2",  :integer}
    @oid_ipRouteMetric1   {"#{@oid_ipRouteEntry}.3",  :integer}
    @oid_ipRouteMetric2   {"#{@oid_ipRouteEntry}.4",  :integer}
    @oid_ipRouteMetric3   {"#{@oid_ipRouteEntry}.5",  :integer}
    @oid_ipRouteMetric4   {"#{@oid_ipRouteEntry}.6",  :integer}
    @oid_ipRouteNextHop   {"#{@oid_ipRouteEntry}.7",  :string}
    @oid_ipRouteType      {"#{@oid_ipRouteEntry}.8",  :integer}
    @oid_ipRouteProto     {"#{@oid_ipRouteEntry}.9",  :integer}
    @oid_ipRouteAge       {"#{@oid_ipRouteEntry}.10", :integer}
    @oid_ipRouteMask      {"#{@oid_ipRouteEntry}.11", :string}
    @oid_ipRouteMetric5   {"#{@oid_ipRouteEntry}.12", :integer}
    @oid_ipRouteInfo      {"#{@oid_ipRouteEntry}.13", :oid}

    defstruct [
      ipRouteDest:      nil,
      ipRouteIfIndex:   nil,
      ipRouteMetric1:   nil,
      ipRouteMetric2:   nil,
      ipRouteMetric3:   nil,
      ipRouteMetric4:   nil,
      ipRouteNextHop:   nil,
      ipRouteType:      nil,
      ipRouteProto:     nil,
      ipRouteAge:       nil,
      ipRouteMask:      nil,
      ipRouteMetric5:   nil,
      ipRouteInfo:      nil
    ]

    @type t :: %IPRouteEntry{
      ipRouteDest:      String.t,
      ipRouteIfIndex:   integer,
      ipRouteMetric1:   integer,
      ipRouteMetric2:   integer,
      ipRouteMetric3:   integer,
      ipRouteMetric4:   integer,
      ipRouteNextHop:   String.t,
      ipRouteType:      IPRouteTable.ipRouteType,
      ipRouteProto:     IPRouteTable.ipRouteProto,
      ipRouteAge:       integer,
      ipRouteMask:      String.t,
      ipRouteMetric5:   integer,
      ipRouteInfo:      String.t
    }

    def ipRouteIfIndex do
      ipRouteIfIndex(%IPRouteEntry{})
    end
    def ipRouteIfIndex(ipRouteEntry) do
      {oid, type} = @oid_ipRouteIfIndex

      SNMPMIB.object(oid, type, ipRouteEntry.ipRouteIfIndex)
    end
    def ipRouteIfIndex(ipRouteEntry, value) do
      %IPRouteEntry{ipRouteEntry|ipRouteIfIndex: value}
    end

    def ipRouteType do
      ipRouteType(%IPRouteEntry{})
    end
    def ipRouteType(ipRouteEntry) do
      {oid, type} = @oid_ipRouteType

      SNMPMIB.object(oid, type, ipRouteEntry.ipRouteType)
    end
    def ipRouteType(ipRouteEntry, value) do
      value = CiscoConfigCopy.typeIpRouteType |> Map.fetch!(value)

      %IPRouteEntry{ipRouteEntry|ipRouteType: value}
    end
  end

  def ip_route_entry(destination,
                     if_index,
                     metric1,
                     metric2,
                     metric3,
                     metric4,
                     next_hop,
                     type,
                     protocol,
                     age,
                     mask,
                     metric5,
                     info) do
    %IPRouteEntry{
      ipRouteDest:      destination,
      ipRouteIfIndex:   if_index,
      ipRouteMetric1:   metric1,
      ipRouteMetric2:   metric2,
      ipRouteMetric3:   metric3,
      ipRouteMetric4:   metric4,
      ipRouteNextHop:   next_hop,
      ipRouteType:      type,
      ipRouteProto:     protocol,
      ipRouteAge:       age,
      ipRouteMask:      mask,
      ipRouteMetric5:   metric5,
      ipRouteInfo:      info
    }
  end
end

