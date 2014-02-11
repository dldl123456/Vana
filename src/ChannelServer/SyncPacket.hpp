/*
Copyright (C) 2008-2014 Vana Development Team

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; version 2
of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
#pragma once

#include "InterHelper.hpp"
#include "PacketBuilder.hpp"
#include "PlayerObjects.hpp"
#include "Types.hpp"
#include <string>
#include <vector>

class Player;
struct Rates;

namespace SyncPacket {
	namespace ConfigPacket {
		PACKET(scrollingHeader, const string_t &message);
		PACKET(resetRates);
		PACKET(modifyRates, const Rates &rates);
	}
	namespace PlayerPacket {
		PACKET(changeChannel, Player *info, channel_id_t channel);
		PACKET(connectableEstablished, int32_t playerId);
		PACKET(connect, const PlayerData &player, bool firstConnect);
		PACKET(disconnect, int32_t playerId);
		PACKET(updatePlayer, const PlayerData &player, update_bits_t flags);
	}
	namespace PartyPacket {
		PACKET(sync, int8_t type, int32_t playerId, int32_t target = 0);
	}
	namespace BuddyPacket {
		PACKET(buddyInvite, int32_t inviterId, int32_t inviteeId);
		PACKET(buddyOnline, int32_t playerId, const vector_t<int32_t> &players, bool online);
	}
}