/*
Copyright (C) 2008-2015 Vana Development Team

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

#include "Common/ServerAcceptedSession.hpp"
#include "Common/Types.hpp"

namespace Vana {
	class PacketReader;

	namespace LoginServer {
		class LoginServerAcceptedSession final : public ServerAcceptedSession, public enable_shared<LoginServerAcceptedSession> {
			NONCOPYABLE(LoginServerAcceptedSession);
		public:
			LoginServerAcceptedSession(AbstractServer &server);

			auto setWorldId(world_id_t id) -> void;
			auto getWorldId() const -> optional_t<world_id_t>;
		protected:
			auto handle(PacketReader &reader) -> Result override;
			auto authenticated(ServerType type) -> void override;
			auto onDisconnect() -> void override;
		private:
			optional_t<world_id_t> m_worldId;
		};
	}
}