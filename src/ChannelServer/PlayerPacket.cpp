/*
Copyright (C) 2008 Vana Development Team

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
#include "PlayerPacket.h"
#include "PacketCreator.h"
#include "Player.h"
#include "Inventory.h"
#include "Skills.h"
#include "TimeUtilities.h"
#include "PlayerPacketHelper.h"
#include "Randomizer.h"
#include "SendHeader.h"

void PlayerPacket::connectData(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_CHANGE_MAP);
	packet.addInt(player->getChannel()); // Channel
	packet.addByte(1);
	packet.addByte(1);
	packet.addInt(Randomizer::Instance()->randInt()); //
	packet.addInt(Randomizer::Instance()->randInt()); // Possibly seeding maple's rng
	packet.addInt(Randomizer::Instance()->randInt()); //
	packet.addShort(-1);
	packet.addInt(player->getPlayerid());
	packet.addString(player->getName(), 12);
	packet.addByte(0);
	packet.addByte(player->getGender());
	packet.addByte(player->getSkin());
	packet.addInt(player->getEyes());
	packet.addInt(player->getHair());
	packet.addInt(0);
	packet.addInt(0);
	packet.addInt(0);
	packet.addInt(0);
	packet.addInt(0);
	packet.addInt(0);
	packet.addByte(player->getLevel());
	packet.addShort(player->getJob());
	packet.addShort(player->getStr());
	packet.addShort(player->getDex());
	packet.addShort(player->getInt());
	packet.addShort(player->getLuk());
	packet.addShort(player->getHP());
	packet.addShort(player->getMHP());
	packet.addShort(player->getMP());
	packet.addShort(player->getMMP());
	packet.addShort(player->getAp());
	packet.addShort(player->getSp());
	packet.addInt(player->getExp());
	packet.addShort(player->getFame());
	packet.addInt(player->getMap());
	packet.addByte(player->getMappos());
	packet.addByte(0x14);
	packet.addInt(player->inv->getMesos());
	packet.addByte(100);
	packet.addByte(100);
	packet.addByte(100);
	packet.addByte(100);
	packet.addByte(100);
	for(int i=0; i<player->inv->getEquipNum(); i++){
		Equip* equip = player->inv->getEquip(i);
		if(equip->pos<0 && !Inventory::isCash(equip->id)){
			PlayerPacketHelper::addEquip(packet, equip);
		}
	}
	packet.addByte(0);
	for(int i=0; i<player->inv->getEquipNum(); i++){
		Equip* equip = player->inv->getEquip(i);
		if(equip->pos<0 && Inventory::isCash(equip->id)){
			PlayerPacketHelper::addEquip(packet, equip);
		}
	}
	packet.addByte(0);
	for(int i=0; i<player->inv->getEquipNum(); i++){
		Equip* equip = player->inv->getEquip(i);
		if(equip->pos>0){
			PlayerPacketHelper::addEquip(packet, equip);
		}
	}
	packet.addByte(0);
	for(int j=2; j<=5; j++){
		for(int i=0; i<player->inv->getItemNum(); i++){
			Item* item = player->inv->getItem(i);
			if(item->inv == j){
				packet.addByte((char)item->pos);
				packet.addByte(2);
				packet.addInt(item->id);
				packet.addShort(0);
				packet.addBytes("8005BB46E61702");
				packet.addShort(item->amount); // slots
				packet.addInt(0);			
				if(ISSTAR(item->id)){
					packet.addInt(2);
					packet.addShort(0x54);
					packet.addByte(0);
					packet.addByte(0x34);
				}
			}
		}
		packet.addByte(0);

	}
	//Skills
	packet.addShort(player->skills->getSkillsNum());
	for(int i=0; i<player->skills->getSkillsNum(); i++){
		packet.addInt(player->skills->getSkillID(i));
		packet.addInt(player->skills->getSkillLevel(player->skills->getSkillID(i)));
		if(FORTHJOB_SKILL(player->skills->getSkillID(i)))
			packet.addInt(player->skills->getMaxSkillLevel(player->skills->getSkillID(i))); // Max Level for 4th job skills
	}
	//End
	packet.addInt(0);
	packet.addInt(0);
	packet.addInt(0);
	packet.addShort(0);
	for(int i=0; i<15; i++)
		packet.addBytes("FFC99A3B");
	packet.addInt64(TimeUtilities::getServerTime());
	packet.packetSend(player);
}

void PlayerPacket::newHP(Player* player, short hp){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addByte(0);
	packet.addShort(0);
	packet.addShort(4);
	packet.addByte(0);
	packet.addShort(hp); 
	packet.packetSend(player);
}

void PlayerPacket::newMP(Player* player, short mp, bool is){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addByte(is);
	packet.addShort(0);
	packet.addShort(0x10);
	packet.addByte(0);
	packet.addShort(mp);
	packet.packetSend(player);
}

void PlayerPacket::newEXP(Player* player, int exp){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addShort(0);
	packet.addShort(1);
	packet.addInt(exp);
	packet.packetSend(player);
}


void PlayerPacket::showKeys(Player* player, int keys[90]){
	Packet packet = Packet();
	packet.addHeader(SEND_KEYMAP);
	packet.addByte(0);
	for(int i=0; i<90; i++){
		packet.addInt(keys[i]);
		packet.addByte(0);
	}
	packet.packetSend(player);
}
void PlayerPacket::setSP(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addByte(0);
	packet.addShort(0x80);
	packet.addByte(0);
	packet.addShort(player->getSp());
	packet.packetSend(player);
}
void PlayerPacket::setAP(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addByte(0);
	packet.addShort(0x40);
	packet.addByte(0);
	packet.addShort(player->getAp());
	packet.packetSend(player);
}
void PlayerPacket::setJob(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addInt(0x20);
	packet.addShort(player->getJob());
	packet.packetSend(player);
}

void PlayerPacket::newHair(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addInt(0x4);
	packet.addInt(player->getHair());
	packet.packetSend(player);
}

void PlayerPacket::newEyes(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addInt(0x2);
	packet.addInt(player->getEyes());
	packet.packetSend(player);
}

void PlayerPacket::newSkin(Player* player){
	Packet packet = Packet();
	packet.addHeader(SEND_UPDATE_STAT);
	packet.addShort(0);
	packet.addInt(0x1);
	packet.addByte(player->getSkin());
	packet.packetSend(player);
}

void PlayerPacket::changeChannel(Player *player, char *ip, short port) {
	Packet packet = Packet();
	packet.addHeader(SEND_CHANGE_CHANNEL);
	packet.addByte(1);
	PlayerPacketHelper::addIP(packet, ip, port);
	packet.packetSend(player);
}

void PlayerPacket::showMessage(Player *player, char *msg, char type){
	Packet packet = Packet();
	packet.addHeader(SEND_NOTICE); 
	packet.addByte(type);
	packet.addShort(strlen(msg));
	packet.addString(msg, strlen(msg));
	packet.packetSend(player);
}
