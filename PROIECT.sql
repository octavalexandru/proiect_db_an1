-- Sequences for Primary Keys
CREATE SEQUENCE PlayerSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CharacterSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE NPCSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE MonsterSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LocationSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE QuestSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ItemSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SpellSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE EncounterSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE EventSeq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CampaignSeq START WITH 1 INCREMENT BY 1;

-- Players Table
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    Name VARCHAR2(100),
    ContactInfo VARCHAR2(255),
    Notes CLOB
);

-- Characters Table
CREATE TABLE Characters (
    CharacterID INT PRIMARY KEY,
    PlayerID INT,
    Char_Name VARCHAR2(100),
    Race VARCHAR2(50),
    Char_Class VARCHAR2(50),
    Char_Level INT,
    Alignment VARCHAR2(20),
    Background VARCHAR2(100),
    HitPoints INT,
    ArmorClass INT,
    Strength INT,
    Dexterity INT,
    Constitution INT,
    Intelligence INT,
    Wisdom INT,
    Charisma INT,
    Skills CLOB,
    Inventory CLOB,
    Spells CLOB,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

-- NPCs Table
CREATE TABLE NPCs (
    NPCID INT PRIMARY KEY,
    NPC_Name VARCHAR2(100),
    NPC_Role VARCHAR2(50),
    Race VARCHAR2(50),
    NPC_Class VARCHAR2(50),
    NPC_Description CLOB,
    LocationID INT,
    Notes CLOB,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Monsters Table
CREATE TABLE Monsters (
    MonsterID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Type VARCHAR2(50),
    HitPoints INT,
    ArmorClass INT,
    Strength INT,
    Dexterity INT,
    Constitution INT,
    Intelligence INT,
    Wisdom INT,
    Charisma INT,
    Skills CLOB,
    Actions CLOB,
    ChallengeRating FLOAT,
    Notes CLOB
);

-- Locations Table
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Description CLOB,
    Region VARCHAR2(100),
    Notes CLOB
);

-- Quests Table
CREATE TABLE Quests (
    QuestID INT PRIMARY KEY,
    Title VARCHAR2(100),
    Description CLOB,
    Status VARCHAR2(20),
    Rewards CLOB,
    QuestGiverID INT,
    Notes CLOB,
    FOREIGN KEY (QuestGiverID) REFERENCES NPCs(NPCID)
);

-- Items Table
CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Type VARCHAR2(50),
    Description CLOB,
    Effects CLOB,
    Value INT,
    OwnerID INT,
    FOREIGN KEY (OwnerID) REFERENCES Characters(CharacterID)
);

-- Spells Table
CREATE TABLE Spells (
    SpellID INT PRIMARY KEY,
    Spell_Name VARCHAR2(100),
    Spell_Level INT,
    School VARCHAR2(50),
    Description CLOB,
    CharacterID INT,
    FOREIGN KEY (CharacterID) REFERENCES Characters(CharacterID)
);

-- Encounters Table
CREATE TABLE Encounters (
    EncounterID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Description CLOB,
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Events Table
CREATE TABLE Events (
    EventID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Description CLOB,
    EventDate DATE,
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Join Tables

-- CharacterQuests Join Table
CREATE TABLE CharacterQuests (
    CharacterID INT,
    QuestID INT,
    PRIMARY KEY (CharacterID, QuestID),
    FOREIGN KEY (CharacterID) REFERENCES Characters(CharacterID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID)
);

-- CharacterEncounters Join Table
CREATE TABLE CharacterEncounters (
    CharacterID INT,
    EncounterID INT,
    PRIMARY KEY (CharacterID, EncounterID),
    FOREIGN KEY (CharacterID) REFERENCES Characters(CharacterID),
    FOREIGN KEY (EncounterID) REFERENCES Encounters(EncounterID)
);

-- CharacterEvents Join Table
CREATE TABLE CharacterEvents (
    CharacterID INT,
    EventID INT,
    PRIMARY KEY (CharacterID, EventID),
    FOREIGN KEY (CharacterID) REFERENCES Characters(CharacterID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- QuestNPCs Join Table (Many-to-Many relationship between Quests and NPCs)
CREATE TABLE QuestNPCs (
    QuestID INT,
    NPCID INT,
    PRIMARY KEY (QuestID, NPCID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID),
    FOREIGN KEY (NPCID) REFERENCES NPCs(NPCID)
);

-- QuestLocations Join Table (Many-to-Many relationship between Quests and Locations)
CREATE TABLE QuestLocations (
    QuestID INT,
    LocationID INT,
    PRIMARY KEY (QuestID, LocationID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- EncounterMonsters Join Table (Many-to-Many relationship between Encounters and Monsters)
CREATE TABLE EncounterMonsters (
    EncounterID INT,
    MonsterID INT,
    PRIMARY KEY (EncounterID, MonsterID),
    FOREIGN KEY (EncounterID) REFERENCES Encounters(EncounterID),
    FOREIGN KEY (MonsterID) REFERENCES Monsters(MonsterID)
);

-- Campaigns Table
CREATE TABLE Campaigns (
    CampaignID INT PRIMARY KEY,
    Name VARCHAR2(100),
    Description CLOB,
    StartDate DATE,
    EndDate DATE,
    CurrentLocationID INT,
    Notes CLOB,
    FOREIGN KEY (CurrentLocationID) REFERENCES Locations(LocationID)
);

-- CampaignCharacters Join Table (Many-to-Many relationship between Campaigns and Characters)
CREATE TABLE CampaignCharacters (
    CampaignID INT,
    CharacterID INT,
    PRIMARY KEY (CampaignID, CharacterID),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
    FOREIGN KEY (CharacterID) REFERENCES Characters(CharacterID)
);

-- CampaignNPCs Join Table (Many-to-Many relationship between Campaigns and NPCs)
CREATE TABLE CampaignNPCs (
    CampaignID INT,
    NPCID INT,
    PRIMARY KEY (CampaignID, NPCID),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
    FOREIGN KEY (NPCID) REFERENCES NPCs(NPCID)
);

-- CampaignMonsters Join Table (Many-to-Many relationship between Campaigns and Monsters)
CREATE TABLE CampaignMonsters (
    CampaignID INT,
    MonsterID INT,
    PRIMARY KEY (CampaignID, MonsterID),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
    FOREIGN KEY (MonsterID) REFERENCES Monsters(MonsterID)
);

-- CampaignQuests Join Table (Many-to-Many relationship between Campaigns and Quests)
CREATE TABLE CampaignQuests (
    CampaignID INT,
    QuestID INT,
    PRIMARY KEY (CampaignID, QuestID),
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
    FOREIGN KEY (QuestID) REFERENCES Quests(QuestID)
);


-- Insertions for Players Table
INSERT INTO Players (PlayerID, Name, ContactInfo, Notes) VALUES (PlayerSeq.NEXTVAL, 'John Doe', 'john.doe@example.com', 'Loves role-playing.');
INSERT INTO Players (PlayerID, Name, ContactInfo, Notes) VALUES (PlayerSeq.NEXTVAL, 'Jane Smith', 'jane.smith@example.com', 'Enjoys strategic play.');
INSERT INTO Players (PlayerID, Name, ContactInfo, Notes) VALUES (PlayerSeq.NEXTVAL, 'Alice Johnson', 'alice.johnson@example.com', 'Prefers magical characters.');
INSERT INTO Players (PlayerID, Name, ContactInfo, Notes) VALUES (PlayerSeq.NEXTVAL, 'Bob Brown', 'bob.brown@example.com', 'Always the dungeon master.');
INSERT INTO Players (PlayerID, Name, ContactInfo, Notes) VALUES (PlayerSeq.NEXTVAL, 'Charlie White', 'charlie.white@example.com', 'New to the game.');
INSERT INTO Players (PlayerID, Name, ContactInfo, Notes) VALUES (PlayerSeq.NEXTVAL, 'Diana Black', 'diana.black@example.com', 'Writes character backstories.');

-- Insertions for Characters Table
INSERT INTO Characters (CharacterID, PlayerID, Char_Name, Race, Char_Class, Char_Level, Alignment, Background, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Inventory, Spells) 
VALUES (CharacterSeq.NEXTVAL, 1, 'Tharivol', 'Elf', 'Wizard', 5, 'Neutral Good', 'Sage', 30, 12, 8, 14, 10, 18, 12, 14, 'Arcana, History', 'Staff, Robes', 'Fireball, Magic Missile');
INSERT INTO Characters (CharacterID, PlayerID, Char_Name, Race, Char_Class, Char_Level, Alignment, Background, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Inventory, Spells) 
VALUES (CharacterSeq.NEXTVAL, 2, 'Grog', 'Half-Orc', 'Barbarian', 4, 'Chaotic Neutral', 'Outlander', 50, 15, 18, 12, 16, 8, 10, 10, 'Athletics, Survival', 'Great Axe, Javelin', NULL);
INSERT INTO Characters (CharacterID, PlayerID, Char_Name, Race, Char_Class, Char_Level, Alignment, Background, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Inventory, Spells) 
VALUES (CharacterSeq.NEXTVAL, 3, 'Lia', 'Human', 'Rogue', 3, 'Chaotic Good', 'Criminal', 20, 14, 10, 18, 12, 14, 10, 12, 'Stealth, Sleight of Hand', 'Dagger, Thieves Tools', 'Invisibility, Sneak Attack');
INSERT INTO Characters (CharacterID, PlayerID, Char_Name, Race, Char_Class, Char_Level, Alignment, Background, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Inventory, Spells) 
VALUES (CharacterSeq.NEXTVAL, 4, 'Bor', 'Dwarf', 'Cleric', 6, 'Lawful Good', 'Acolyte', 40, 16, 14, 10, 18, 10, 12, 8, 'Medicine, Religion', 'Mace, Shield', 'Healing Word, Bless');
INSERT INTO Characters (CharacterID, PlayerID, Char_Name, Race, Char_Class, Char_Level, Alignment, Background, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Inventory, Spells) 
VALUES (CharacterSeq.NEXTVAL, 5, 'Eldrin', 'Half-Elf', 'Sorcerer', 2, 'Neutral Evil', 'Charlatan', 18, 12, 10, 14, 12, 16, 14, 18, 'Deception, Persuasion', 'Wand, Ring of Protection', 'Charm Person, Magic Missile');
INSERT INTO Characters (CharacterID, PlayerID, Char_Name, Race, Char_Class, Char_Level, Alignment, Background, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Inventory, Spells) 
VALUES (CharacterSeq.NEXTVAL, 6, 'Fiona', 'Tiefling', 'Warlock', 5, 'Neutral', 'Hermit', 28, 13, 10, 14, 12, 18, 14, 12, 'Arcana, Investigation', 'Pact Blade, Tome of Shadows', 'Eldritch Blast, Hex');

-- Insertions for NPCs Table
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Tormac', 'Blacksmith', 'Human', 'None', 'A burly man with a stern face.', 1, 'Works tirelessly.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Elara', 'Innkeeper', 'Half-Elf', 'None', 'A friendly and talkative woman.', 2, 'Knows many local secrets.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Grim', 'Guard Captain', 'Dwarf', 'Fighter', 'A stern and experienced warrior.', 3, 'Loyal to the city.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Mira', 'Merchant', 'Tiefling', 'None', 'A shrewd businesswoman.', 4, 'Always has rare items.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Dorn', 'Priest', 'Human', 'Cleric', 'A gentle and kind-hearted man.', 5, 'Heals the sick for free.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Kara', 'Scholar', 'Elf', 'Wizard', 'An old and wise elf.', 6, 'Loves ancient texts.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Thorn', 'Rogue', 'Half-Orc', 'Rogue', 'A cunning and agile figure.', 7, 'Always in the shadows.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Syla', 'Hunter', 'Halfling', 'Ranger', 'A cheerful and skilled tracker.', 8, 'Knows the forests well.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Gorn', 'Fisherman', 'Human', 'None', 'A quiet and solitary man.', 9, 'Has a mysterious past.');
INSERT INTO NPCs (NPCID, NPC_Name, NPC_Role, Race, NPC_Class, NPC_Description, LocationID, Notes) VALUES (NPCSeq.NEXTVAL, 'Lyla', 'Seer', 'Elf', 'Sorcerer', 'A mystical and enigmatic figure.', 10, 'Foresees future events.');



-- Insertions for Monsters Table
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Goblin', 'Humanoid', 7, 15, 8, 14, 10, 10, 8, 8, 'Stealth', 'Scimitar, Shortbow', 0.25, 'Weak but cunning.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Orc', 'Humanoid', 15, 13, 16, 12, 14, 8, 10, 10, 'Intimidation', 'Great Axe, Javelin', 0.5, 'Aggressive.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Troll', 'Giant', 84, 15, 18, 13, 20, 7, 9, 7, 'Regeneration', 'Bite, Claw', 5, 'Regenerates health.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Dragon', 'Dragon', 200, 19, 23, 10, 21, 18, 15, 19, 'Flight, Breath Weapon', 'Bite, Claw, Tail Swipe', 10, 'Very powerful.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Skeleton', 'Undead', 13, 13, 10, 14, 15, 6, 8, 5, 'Stealth', 'Shortsword, Shortbow', 0.25, 'Resistant to poison.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Zombie', 'Undead', 22, 8, 13, 6, 16, 3, 6, 5, 'Undead Fortitude', 'Slam', 0.25, 'Slow but tough.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Giant Spider', 'Beast', 26, 14, 14, 16, 12, 2, 11, 4, 'Stealth, Web', 'Bite', 1, 'Can climb walls.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Ogre', 'Giant', 59, 11, 19, 8, 16, 5, 7, 7, 'Intimidation', 'Greatclub, Javelin', 2, 'Very strong.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Kobold', 'Humanoid', 5, 12, 7, 15, 9, 8, 7, 8, 'Stealth', 'Dagger, Sling', 0.125, 'Weak but numerous.');
INSERT INTO Monsters (MonsterID, Name, Type, HitPoints, ArmorClass, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, Skills, Actions, ChallengeRating, Notes) 
VALUES (MonsterSeq.NEXTVAL, 'Wyvern', 'Dragon', 110, 13, 19, 10, 17, 5, 12, 6, 'Flight, Poison Sting', 'Bite, Stinger', 6, 'Poisonous tail.');

-- Insertions for Locations Table
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Thundertree', 'A ruined village.', 'Neverwinter Wood', 'Overrun by undead.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Phandalin', 'A frontier town.', 'Sword Coast', 'Recently resettled.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Waterdeep', 'A bustling city.', 'Sword Coast', 'Known as the City of Splendors.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Baldurs Gate', 'A major trading hub.', 'Western Heartlands', 'Home to many adventurers.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Neverwinter', 'A beautiful city.', 'Sword Coast', 'Rebuilt after a volcanic eruption.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Luskan', 'A lawless city.', 'Sword Coast', 'Ruled by pirate lords.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Daggerford', 'A small town.', 'Sword Coast', 'Protective of its independence.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Greenest', 'A peaceful village.', 'Greenfields', 'Attacked by a dragon.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Red Larch', 'A crossroads village.', 'Dessarin Valley', 'Center of trade.');
INSERT INTO Locations (LocationID, Name, Description, Region, Notes) VALUES (LocationSeq.NEXTVAL, 'Yartar', 'A fortified town.', 'Dessarin Valley', 'Known for its fish market.');

-- Insertions for Quests Table
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Save the Village', 'Defend the village from orcs.', 'Open', '500 gold', 11, 'Urgent.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Find the Artifact', 'Locate the lost artifact in the ruins.', 'Open', 'Rare magic item', 12, 'Artifact is ancient.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Rescue the Prince', 'Rescue the prince from the dragon.', 'Open', '1000 gold', 13, 'Prince is in grave danger.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Deliver the Message', 'Deliver the message to the king.', 'Open', '200 gold', 14, 'Message is confidential.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Hunt the Monster', 'Track and kill the monster.', 'Open', '300 gold', 15, 'Monster is very dangerous.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Escort the Caravan', 'Escort the caravan safely to its destination.', 'Open', '150 gold', 16, 'Caravan contains valuable goods.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Investigate the Cave', 'Investigate the strange noises in the cave.', 'Open', '250 gold', 17, 'Cave is haunted.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Protect the Merchant', 'Protect the merchant from bandits.', 'Open', '100 gold', 18, 'Merchant is wealthy.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Explore the Forest', 'Explore the uncharted forest.', 'Open', '50 gold', 19, 'Forest is dangerous.');
INSERT INTO Quests (QuestID, Title, Description, Status, Rewards, QuestGiverID, Notes) VALUES (QuestSeq.NEXTVAL, 'Retrieve the Book', 'Retrieve the stolen book from the thieves.', 'Open', '75 gold', 20, 'Book is very important.');

-- Insertions for Spells Table
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Fireball', 3, 'Evocation', 'A ball of fire that explodes on impact.', 1);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Heal', 6, 'Necromancy', 'A spell that heals injuries.', 2);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Invisibility', 2, 'Illusion', 'A spell that makes the caster invisible.', 3);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Lightning Bolt', 3, 'Evocation', 'A bolt of lightning that strikes enemies.', 4);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Teleport', 7, 'Conjuration', 'A spell that teleports the caster to a known location.', 5);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Charm Person', 1, 'Enchantment', 'A spell that charms a person.', 6);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Shield', 1, 'Abjuration', 'A spell that provides temporary protection.', 3);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Cone of Cold', 5, 'Evocation', 'A cone of cold air that damages enemies.', 2);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Fly', 3, 'Transmutation', 'A spell that grants the ability to fly.', 5);
INSERT INTO Spells (SpellID, Spell_Name, Spell_Level, School, Description, CharacterID) VALUES (SpellSeq.NEXTVAL, 'Disintegrate', 6, 'Transmutation', 'A spell that disintegrates a target.', 1);

-- Insertions for Encounters Table
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Bandit Ambush', 'A group of bandits ambush the party.', 1);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Dragon Attack', 'A dragon attacks the town.', 2);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Goblin Raid', 'Goblins raid the village.', 3);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Haunted Woods', 'The party encounters ghosts in the woods.', 4);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Ogre Assault', 'An ogre attacks the party.', 5);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Undead Uprising', 'Undead rise from their graves.', 6);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Treasure Hunt', 'The party finds a hidden treasure.', 7);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Lost Merchant', 'The party finds a lost merchant.', 8);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Witchs Curse', 'A witch curses the party.', 9);
INSERT INTO Encounters (EncounterID, Name, Description, LocationID) VALUES (EncounterSeq.NEXTVAL, 'Forest Fire', 'The party encounters a forest fire.', 10);

-- Insertions for Events Table
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Harvest Festival', 'A festival celebrating the harvest.', TO_DATE('2023-10-01', 'YYYY-MM-DD'), 1);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Royal Wedding', 'The wedding of the prince and princess.', TO_DATE('2023-12-15', 'YYYY-MM-DD'), 2);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Winter Solstice', 'A celebration of the winter solstice.', TO_DATE('2023-12-21', 'YYYY-MM-DD'), 3);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Mages Conclave', 'A gathering of powerful mages.', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 4);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Merchants Fair', 'A fair where merchants sell their goods.', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 5);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Summer Carnival', 'A carnival celebrating summer.', TO_DATE('2024-06-21', 'YYYY-MM-DD'), 6);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Dragon Festival', 'A festival in honor of dragons.', TO_DATE('2024-08-08', 'YYYY-MM-DD'), 7);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Founders Day', 'A celebration of the founding of the town.', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 8);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Spring Equinox', 'A celebration of the spring equinox.', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 9);
INSERT INTO Events (EventID, Name, Description, EventDate, LocationID) VALUES (EventSeq.NEXTVAL, 'Kings Birthday', 'A celebration of the kings birthday.', TO_DATE('2024-04-10', 'YYYY-MM-DD'), 10);

--1. Ob?ine?i informa?ii despre juc?tori cu detalii despre personaje ?i misiuni active
SELECT p.Name AS PlayerName, c.Char_Name AS CharacterName, c.Char_Class, c.Char_Level, c.Race,
       q.Title AS QuestTitle, q.Description AS QuestDescription, q.Status
FROM Players p
JOIN Characters c ON p.PlayerID = c.PlayerID
LEFT JOIN CharacterQuests cq ON c.CharacterID = cq.CharacterID
LEFT JOIN Quests q ON cq.QuestID = q.QuestID AND q.Status = 'Open'
WHERE p.PlayerID = 1; -- Replace with the specific PlayerID

--2. Lista?i personajele cu vr?ji ?i descrierile lor
SELECT c.Char_Name AS NumePersonaj, s.Spell_Name, s.Spell_Level, s.Description
FROM Characters c
JOIN Spells s ON c.CharacterID = s.CharacterID
ORDER BY c.Char_Name, s.Spell_Level;

--3. Calcula?i punctele de via?? totale pentru mon?tri dup? tip ?i grad de provocare
SELECT m.Type, m.ChallengeRating, SUM(m.HitPoints) AS TotalHitPoints
FROM Monsters m
GROUP BY m.Type, m.ChallengeRating
ORDER BY TotalHitPoints DESC;

--4. Lista?i misiunile active ?i NPC-urile care le-au atribuit dup? loca?ie
SELECT q.Title AS TitluMisiune, q.Description AS DescriereMisiune, q.Status, n.NPC_Name AS D?t?torMisiune, l.Name AS Loca?ieMisiune
FROM Quests q
JOIN NPCs n ON q.QuestGiverID = n.NPCID
JOIN QuestLocations ql ON q.QuestID = ql.QuestID
JOIN Locations l ON ql.LocationID = l.LocationID
WHERE q.Status = 'Deschis'
ORDER BY q.Status, l.Name;

--5. Lista?i campaniile ?i personajele cu NPC-urile lor asociate
SELECT cam.Name AS NumeCampanie, c.Char_Name AS NumePersonaj, n.NPC_Name AS NumeNPC, cc.Role AS RolPersonaj, cn.Role AS RolNPC
FROM Campaigns cam
LEFT JOIN CampaignCharacters cc ON cam.CampaignID = cc.CampaignID
LEFT JOIN Characters c ON cc.CharacterID = c.CharacterID
LEFT JOIN CampaignNPCs cn ON cam.CampaignID = cn.CampaignID
LEFT JOIN NPCs n ON cn.NPCID = n.NPCID
ORDER BY cam.Name, c.Char_Name, n.NPC_Name;


