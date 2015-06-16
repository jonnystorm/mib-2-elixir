# Copyright © 2015 Jonathan Storm <the.jonathan.storm@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

defmodule MIB2.At do
    @oid_MIB_2_at "1.3.6.1.2.1.3"

    defmodule AtEntry do
      @oid_atEntry "1.3.6.1.2.1.3.1.1"

      @oid_atIfIndex     {"#{@oid_atEntry}.1", :integer}
      @oid_atPhysAddress {"#{@oid_atEntry}.2", :string}
      @oid_atNetAddress  {"#{@oid_atEntry}.3", :string}

      defstruct [atIfIndex: nil, atPhysAddress: nil, atNetAddress: nil]

      @type t :: %AtEntry{
        atIfIndex: MIB2.At.atIfIndex,
        atPhysAddress: MIB2.At.atPhysAddress,
        atNetAddress: MIB2.At.atNetAddress
      }

      def atIfIndex do
        atIfIndex(%AtEntry{})
      end
      def atIfIndex(atEntry) do
        {oid, type} = @oid_atIfIndex

        SNMPMIB.object(oid, type, atEntry.atIfIndex)
      end
      def atIfIndex(atEntry, value) do
        %AtEntry{atEntry|atIfIndex: value}
      end

      def atPhysAddress do
        atPhysAddress(%AtEntry{})
      end
      def atPhysAddress(atEntry) do
        {oid, type} = @oid_atPhysAddress

        SNMPMIB.object(oid, type, atEntry.atPhysAddress)
      end
      def atPhysAddress(atEntry, value) do
        %AtEntry{atEntry|atPhysAddress: value}
      end

      def atNetAddress do
        atNetAddress(%AtEntry{})
      end
      def atNetAddress(atEntry) do
        {oid, type} = @oid_atNetAddress

        SNMPMIB.object(oid, type, atEntry.atNetAddress)
      end
      def atNetAddress(atEntry, value) do
        %AtEntry{atEntry|atNetAddress: value}
      end
    end

    @spec at_entry(integer, String.t, String.t) :: AtEntry.t
    def at_entry(if_index, physical_address, network_address) do
      %AtEntry{}
        |> AtEntry.atIfIndex(if_index)
        |> AtEntry.atPhysAddress(physical_address)
        |> AtEntry.atNetAddress(network_address)
    end
  end

