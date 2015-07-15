# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule MIB2.IP.IPCIDRRouteTable do
  @oid_MIB_2_ip_ipCidrRouteTable "1.3.6.1.2.1.4.24.4"

  def oid do
    @oid_MIB_2_ip_ipCidrRouteTable
  end

  defp get_key_by_value(dict, value) do
    {k, _} = dict |> Enum.find(fn {_k, v} -> v == value end)

    k
  end 

  # Convenience types: not part of MIB
  @type ipCidrRouteType :: 1..4
  def typeIpCidrRouteType do
    %{
      other:  1,
      reject: 2,
      local:  3,
      remote: 4
    }
  end
  def typeIpCidrRouteType(value) when is_atom(value) do
    typeIpCidrRouteType[value]
  end
  def typeIpCidrRouteType(value) when is_integer(value) do
    get_key_by_value(typeIpCidrRouteType, value)
  end

  @type ipCidrRouteProto :: 1..16
  def typeIpCidrRouteProto do
    %{
      other:       1,
      local:       2,
      netmgmt:     3,
      icmp:        4,
      egp:         5,
      ggp:         6,
      hello:       7,
      rip:         8,
      isis:        9,
      esis:       10,
      ciscoIgrp:  11,
      bbnSpfIgp:  12,
      ospf:       13,
      bgp:        14,
      idpr:       15,
      ciscoEigrp: 16
    }
  end
  def typeIpCidrRouteProto(value) when is_atom(value) do
    typeIpCidrRouteProto[value]
  end
  def typeIpCidrRouteProto(value) when is_integer(value) do
    get_key_by_value(typeIpCidrRouteProto, value)
  end

  # Types defined by MIB
  @type rowStatus :: 1..6
  def typeRowStatus do
    %{
      active:          1,
      not_in_service:  2,
      not_ready:       3,
      create_and_go:   4,
      create_and_wait: 5,
      destroy:         6
    }
  end
  def typeRowStatus(value) when is_atom(value) do
    typeRowStatus[value]
  end
  def typeRowStatus(value) when is_integer(value) do
    get_key_by_value(typeRowStatus, value)
  end

  defmodule IPCidrRouteEntry do
    alias MIB2.IP.IPCidrRouteTable

    @oid_ipCidrRouteEntry "1.3.6.1.2.1.4.24.4.1"

    @oid_ipCidrRouteDest      {"#{@oid_ipCidrRouteEntry}.1",  :string}
    @oid_ipCidrRouteMask      {"#{@oid_ipCidrRouteEntry}.2",  :string}
    @oid_ipCidrRouteTos       {"#{@oid_ipCidrRouteEntry}.3",  :integer}
    @oid_ipCidrRouteNextHop   {"#{@oid_ipCidrRouteEntry}.4",  :string}
    @oid_ipCidrRouteIfIndex   {"#{@oid_ipCidrRouteEntry}.5",  :integer}
    @oid_ipCidrRouteType      {"#{@oid_ipCidrRouteEntry}.6",  :integer}
    @oid_ipCidrRouteProto     {"#{@oid_ipCidrRouteEntry}.7",  :integer}
    @oid_ipCidrRouteAge       {"#{@oid_ipCidrRouteEntry}.8",  :integer}
    @oid_ipCidrRouteInfo      {"#{@oid_ipCidrRouteEntry}.9",  :oid}
    @oid_ipCidrRouteNextHopAS {"#{@oid_ipCidrRouteEntry}.10", :integer}
    @oid_ipCidrRouteMetric1   {"#{@oid_ipCidrRouteEntry}.11", :integer}
    @oid_ipCidrRouteMetric2   {"#{@oid_ipCidrRouteEntry}.12", :integer}
    @oid_ipCidrRouteMetric3   {"#{@oid_ipCidrRouteEntry}.13", :integer}
    @oid_ipCidrRouteMetric4   {"#{@oid_ipCidrRouteEntry}.14", :integer}
    @oid_ipCidrRouteMetric5   {"#{@oid_ipCidrRouteEntry}.15", :integer}
    @oid_ipCidrRouteStatus    {"#{@oid_ipCidrRouteEntry}.16", :integer}

    defstruct [
      ipCidrRouteDest:      nil,
      ipCidrRouteMask:      nil,
      ipCidrRouteTos:       nil,
      ipCidrRouteNextHop:   nil,
      ipCidrRouteIfIndex:     nil,
      ipCidrRouteType:      nil,
      ipCidrRouteProto:     nil,
      ipCidrRouteAge:       nil,
      ipCidrRouteInfo:      nil,
      ipCidrRouteNextHopAS: nil,
      ipCidrRouteMetric1:   nil,
      ipCidrRouteMetric2:   nil,
      ipCidrRouteMetric3:   nil,
      ipCidrRouteMetric4:   nil,
      ipCidrRouteMetric5:   nil,
      ipCidrRouteStatus:    nil
    ]

    @type t :: %IPCidrRouteEntry{
      ipCidrRouteDest:      String.t,
      ipCidrRouteMask:      String.t,
      ipCidrRouteTos:       0|2|4|6|8|10|12|14|16|18|20|22|24|26|28|30,
      ipCidrRouteNextHop:   String.t,
      ipCidrRouteIfIndex:   integer,
      ipCidrRouteType:      IPCidrRouteTable.ipCidrRouteType,
      ipCidrRouteProto:     IPCidrRouteTable.ipCidrRouteProto,
      ipCidrRouteAge:       integer,
      ipCidrRouteInfo:      String.t,
      ipCidrRouteNextHopAS: non_neg_integer,
      ipCidrRouteMetric1:   integer,
      ipCidrRouteMetric2:   integer,
      ipCidrRouteMetric3:   integer,
      ipCidrRouteMetric4:   integer,
      ipCidrRouteMetric5:   integer,
      ipCidrRouteStatus:    IPCidrRouteTable.rowStatus
    }

    def ipCidrRouteIfIndex do
      ipCidrRouteIfIndex(%IPCidrRouteEntry{})
    end
    def ipCidrRouteIfIndex(ipCidrRouteEntry) do
      {oid, type} = @oid_ipCidrRouteIfIndex

      SNMPMIB.object(oid, type, ipCidrRouteEntry.ipCidrRouteIfIndex)
    end
    def ipCidrRouteIfIndex(ipCidrRouteEntry, value) do
      %IPCidrRouteEntry{ipCidrRouteEntry|ipCidrRouteIfIndex: value}
    end

    def ipCidrRouteType do
      ipCidrRouteType(%IPCidrRouteEntry{})
    end
    def ipCidrRouteType(ipCidrRouteEntry) do
      {oid, type} = @oid_ipCidrRouteType

      SNMPMIB.object(oid, type, ipCidrRouteEntry.ipCidrRouteType)
    end
    def ipCidrRouteType(ipCidrRouteEntry, value) do
      value = CiscoConfigCopy.typeIpCidrRouteType |> Map.fetch!(value)

      %IPCidrRouteEntry{ipCidrRouteEntry|ipCidrRouteType: value}
    end
  end

  def ip_cidr_route_entry(destination,
                          mask,
                          type_of_service,
                          next_hop,
                          if_index,
                          type,
                          protocol,
                          age,
                          info,
                          next_hop_as,
                          metric1,
                          metric2,
                          metric3,
                          metric4,
                          metric5,
                          status) do
    %IPCidrRouteEntry{
      ipCidrRouteDest:      destination,
      ipCidrRouteMask:      mask,
      ipCidrRouteTos:       type_of_service,
      ipCidrRouteNextHop:   next_hop,
      ipCidrRouteIfIndex:   if_index,
      ipCidrRouteType:      type,
      ipCidrRouteProto:     protocol,
      ipCidrRouteAge:       age,
      ipCidrRouteInfo:      info,
      ipCidrRouteNextHopAS: next_hop_as,
      ipCidrRouteMetric1:   metric1,
      ipCidrRouteMetric2:   metric2,
      ipCidrRouteMetric3:   metric3,
      ipCidrRouteMetric4:   metric4,
      ipCidrRouteMetric5:   metric5,
      ipCidrRouteStatus:    status
    }
  end
end

