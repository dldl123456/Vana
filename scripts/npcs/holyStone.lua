--[[
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
--]]
-- Holy Stone for third job advancements

dofile("scripts/lua_functions/miscFunctions.lua");

if questions == nil then
	questions = {
		[1] = {
			["question"] = "Which of these NPCs will you see FIRST at MapleStory...?#b\r\n#L0# #p2000##l\r\n#L1# #p1010100##l\r\n#L2# #p2102##l\r\n#L3# #p2001##l\r\n#L4# #p2101##l",
			["answer"] = 0
		},
		[2] = {
			["question"] = "Which of these EXP points is required to go from Lv. 1 to 2...?#b\r\n#L0# 10#l\r\n#L1# 15#l\r\n#L2# 20#l\r\n#L3# 25#l\r\n#L4# 30#l",
			["answer"] = 1
		},
		[3] = {
			["question"] = "Which of these NPCs will you NOT see at El Nath of Ossyria...?#b\r\n#L0# #p2020000##l\r\n#L1# #p2020003##l\r\n#L2# #p2012010##l\r\n#L3# #p2020006##l\r\n#L4# #p2020007##l",
			["answer"] = 2
		},
		[4] = {
			["question"] = "Which of these jobs will you NOT get after the 2nd job advancement...?#b\r\n#L0# Page#l\r\n#L1# Assassin#l\r\n#L2# Bandit#l\r\n#L3# Cleric#l\r\n#L4#Buccaneer#l\r\n",
			["answer"] = 4
		},
		[5] = {
			["question"] = "Which of these quests can be repeated...?#b\r\n#L0# Maya and the Weird Medicine#l\r\n#L1# Alex the Runaway Kid#l\r\n#L2# Pia and the Blue Mushroom#l\r\n#L3# Arwen and the Glass Shoes#l\r\n#L4# Alpha Platoon's Network of Communication#l\r\n",
			["answer"] = 3
		},
		[6] = {
			["question"] = "Which of these pairings of sickness/results resulted from a monster's attack does NOT match...?#b\r\n#L0# State of darkness - decrease in accuracy#l\r\n#L1# State of being cursed - decrease in EXP earned#l\r\n#L2# State of weakness - decrease in speed#l\r\n#L3# State of being sealed up - unable to use skills#l\r\n#L4# State of being poisoned - slow decrease in HP#l",
			["answer"] = 2
		},
		[7] = {
			["question"] = "Which of these NPC's will you NOT see at Orbis of Ossyria...?#b\r\n#L0# Staff Sergeant Charlie#l\r\n#L1# Sophia#l\r\n#L2# Neve#l\r\n#L3# Nuri the Fairy#l\r\n#L4# Edel the Fairy#l",
			["answer"] = 1
		},
		[8] = {
			["question"] = "Which of these quests has the highest required level to start...?#b\r\n#L0# Manji's Old Gladius#l\r\n#L1# Luke the Security Man's Wish to Travel#l\r\n#L2# Looking for the Book of Ancient#l\r\n#L3# Alcaster and the Black Crystal#l\r\n#L4# Alpha Platoon's Network of Communication#l",
			["answer"] = 3
		},
		[9] = {
			["question"] = "Which of these NPC's have NOTHING to do with refining, upgrading, and making items...?#b\r\n#L0# Neve#l\r\n#L1# Mr. Thunder#l\r\n#L2# Shane#l\r\n#L3# Francois#l\r\n#L4# Vogen#l",
			["answer"] = 2
		},
		[10] = {
			["question"] = "In MapleStory, which of these pairings of potion/results matches?#b\r\n#L0# Orange Potion - Recover HP 200#l\r\n#L1# Ice Cream Pop - Recover MP 2000#l\r\n#L2# Lemon - Recover MP 100#l\r\n#L3# Fried Chicken - Recover HP 300#l\r\n#L4# Pizza - Recover HP 400#l",
			["answer"] = 4
		},
		[11] = {
			["question"] = "Which of the pairings of the monster/leftover is correctly matched...?#b\r\n#L0# Fire Boar - Fire Boar's nose#l\r\n#L1# Cold Eye - Cold Eye's Eye#l\r\n#L2# Pig - Pig's ear#l\r\n#L3# Stirge - Stirge Wing#l\r\n#L4# Zombie Mushroom - Zombie Mushroom's top#l",
			["answer"] = 3
		},
		[12] = {
			["question"] = "Which of these NPC's will you NOT see at Perion of Victoria Island?#b\r\n#L0# Arturo#l\r\n#L1# Francois#l\r\n#L2# Manji#l\r\n#L3# Mr. Thunder#l\r\n#L4# Sophia#l",
			["answer"] = 1
		},
		[13] = {
			["question"] = "Which of these NPC's is the father of Alex the Runaway Kid, whom you'll see at Kerning City?#b\r\n#L0# Cloy#l\r\n#L1# Vicious#l\r\n#L2# Lucas#l\r\n#L3# John#l\r\n#L4# Chief Stan#l",
			["answer"] = 4
		},
		[14] = {
			["question"] = "Which of these items will you receive from the NPC after collecting 30 Dark Marbles during the test for the 2nd job advancement?#b\r\n#L0# The Proof of a Hero#l\r\n#L1# Hero's Necklace#l\r\n#L2# Hero's Pendant#l\r\n#L3# Hero's Medal#l\r\n#L4# Hero's Sign#l",
			["answer"] = 0
		},
		[15] = {
			["question"] = "Which of these pairings of job/required stat matches for the 1st job advancement?#b\r\n#L0# Warrior - STR 30+ #l\r\n#L1# Magician - INT 25+ #l\r\n#L2# Bowman - DEX 25+ #l\r\n#L3# Thief - DEX 20+ #l\r\n#L4# Thief - LUK 20+ #l",
			["answer"] = 2
		},
		[16] = {
			["question"] = "Which of these NPC's will you NOT see at Ellinia of Victoria Island...?#b\r\n#L0# Shane#l\r\n#L1# Francois#l\r\n#L2# Grendel the Really Old#l\r\n#L3# Arwen the Fairy#l\r\n#L4# Roel#l",
			["answer"] = 4
		},
		[17] = {
			["question"] = "Which of these monsters will you NOT be facing Ossyria...?#b\r\n#L0# White Fang#l\r\n#L1# Croco#l\r\n#L2# Yeti#l\r\n#L3# Lycanthrope#l\r\n#L4# Luster Pixie#l",
			["answer"] = 1
		},
		[18] = {
			["question"] = "Which of these monsters have the highest level...?#b\r\n#L0# Octopus#l\r\n#L1# Ribbon Pig#l\r\n#L2# Green Mushroom#l\r\n#L3# Axe Stump#l\r\n#L4# Bubbling#l",
			["answer"] = 3
		},
		[19] = {
			["question"] = "In MapleStory, Which of these pairings of potions/results does not match...?#b\r\n#L0# Holy Water - Recover from the state of being cursed or sealed up#l\r\n#L1# Sunrise Dew - Recover MP 3000#l\r\n#L2# Hamburger - Recover HP 400#l\r\n#L3# Salad - Recover MP 200#l\r\n#L4# Blue Potion - Recover MP 100#l",
			["answer"] = 1
		},
		[20] = {
			["question"] = "Which of these NPC's have NOTHING to do with pets...?#b\r\n#L0# Cloy#l\r\n#L1# Mar the Fairy#l\r\n#L2# Trainer Frod#l\r\n#L3# Vicious#l\r\n#L4# Doofus#l",
			["answer"] = 3
		},
		[21] = {
			["question"] = "Which NPC is not a member of the Alpha Platoon scattered over the continent of Ossyria?#b\r\n#L0# Staff Sergeant Peter#l\r\n#L1# Staff Sergeant Charlie#l\r\n#L2# Master Sergeant Fox#l\r\n#L3# Corporal Easy#l\r\n#L4# Sergeant Bravo#l",
			["answer"] = 0
		},
		[22] = {
			["question"] = "Which of the following items is not needed to awaken the Old Gladius from Manji in Perion?#b\r\n#L0# Piece of Ice#l\r\n#L1# Star Rock#l\r\n#L2# Flaming Feather#l\r\n#L3# Fairy Wing#l\r\n#L4# Ancient Scroll#l",
			["answer"] = 3
		},
		[23] = {
			["question"] = "Which of the following monsters can fly?#b\r\n#L0# Hector#l\r\n#L1# Nependeath#l\r\n#L2# Iron Hog#l\r\n#L3# Tortie#l\r\n#L4# Malady#l",
			["answer"] = 4
		},
		[24] = {
			["question"] = "Which of these NPC's will you NOT see at Henesys of Victoria Island...?#b\r\n#L0# Maya#l\r\n#L1# Teo#l\r\n#L2# Rina#l\r\n#L3# Athena Pierce#l\r\n#L4# Pia#l",
			["answer"] = 1
		},
		[25] = {
			["question"] = "Which of these monsters will you NOT see at Maple Island...?#b\r\n#L0# Blue Snail#l\r\n#L1# Orange Mushroom#l\r\n#L2# Red Snail#l\r\n#L3# Pig#l\r\n#L4# Shroom#l",
			["answer"] = 3
		},
		[26] = {
			["question"] = "Which of these items did Maya ask for the cure of her sickness...?#b\r\n#L0# Incredible medicine#l\r\n#L1# Nasty medicine#l\r\n#L2# The all-curing medicine#l\r\n#L3# Chinese medicine#l\r\n#L4# Weird Medicine#l",
			["answer"] = 4
		},
		[27] = {
			["question"] = "Which of these towns is NOT part of Victoria Island...?#b\r\n#L0# Sleepywood#l\r\n#L1# Amherst#l\r\n#L2# Perion#l\r\n#L3# Kerning City#l\r\n#L4# Ellinia#l",
			["answer"] = 1
		},
		[28] = {
			["question"] = "Which of these monsters will you NOT see at the ant tunnel and the center dungeon of Victoria Island...?#b\r\n#L0# Horny Mushroom#l\r\n#L1# Evil Eye#l\r\n#L2# Drake#l\r\n#L3# Zombie Mushroom#l\r\n#L4# Sentinel#l",
			["answer"] = 4
		},
	};
end

if questionRecord == nil then
	questionRecord = {};
end

function question(id)
	local questionId = 0;
	repeat
		questionId = getRandomNumber(#questions);
	until questionRecord[questionId] == nil

	local q = questions[questionId];
	addText("Here's the " .. id .. getOrdinal(id) .. " question. ");
	addText(q["question"]);
	local choice = askChoice();

	if choice == q["answer"] then
		questionRecord[questionId] = true
		return true;
	end
	return false;
end

questState = getPlayerVariable("third_job_advancement", true);
if questState == nil or questState ~= 3 then
	-- TODO: Text?
else
	addText("... ... ...\r\n");
	addText("If you want to test out your wisdom, then you'll have to offer a #b#t4005004##k as a sacrifice ...\r\n");
	addText("Are you ready to offer a #t4005004# and answer a set of questions from me?");
	local ready = askYesNo();

	if ready == 0 then
		addText("Come back when you're ready.");
		sendNext();
	else
		if getItemAmount(4031058) > 0 then
			addText("You already have #b#t4031058##k with you...\r\n");
			addText("Take the necklace and go back...");
			sendNext();
		else
			if getItemAmount(4005004) == 0 then
				addText("If you want me to test your wisdom, you will have to provide a #b#t4005004##k as a sacrifice.");
				sendNext();
			else
				giveItem(4005004, -1);

				addText("Alright ... I'll be testing your wisdom here. ");
				addText("Answer all the questions correctly, and you will pass the test. ");
				addText("But, if you are wrong just once, then you'll have to start over again... ");
				addText("Okay, here we go.");
				sendNext();

				for i = 1, 5 do
					if not question(i) then
						addText("Wrong... Start again...");
						sendNext();
						return;
					end
				end

				addText("Alright. All your answers have been proven as the truth...\r\n");
				addText("Your wisdom has been proven.\r\n");
				addText("Take this necklace and go back...");
				sendNext();

				giveItem(4031058, 1);
			end
		end
	end
end