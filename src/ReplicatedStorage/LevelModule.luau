--!strict

export type SectionInfo = {
	LevelName: string,
	Author: string,
	Color: Color3,
}

local Levels: { [string]: SectionInfo } = {
	['Level1'] = {
		['LevelName'] = 'Sample',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(123, 0, 123),
	},
	['Level2'] = {
		['LevelName'] = 'EatMyBals',
		['Author'] = 'Brolervi',
		['Color'] = Color3.fromRGB(58, 125, 21),
	},
	['Level3'] = {
		['LevelName'] = 'Death Cylinders',
		['Author'] = 'Brolervi',
		['Color'] = Color3.fromRGB(170, 85, 0),
	},
	['Level4'] = {
		['LevelName'] = 'Bridge',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(128, 187, 219),
	},
	['Level5'] = {
		['LevelName'] = 'Lorem Ipsum',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(163, 162, 165),
	},
	['Level6'] = {
		['LevelName'] = 'MoreCylinders',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(255, 102, 204),
	},
	['Level7'] = {
		['LevelName'] = 'BetterBridge',
		['Author'] = 'Brolervi',
		['Color'] = Color3.fromRGB(253, 234, 141),
	},
	['Level8'] = {
		['LevelName'] = 'DeathBridge',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(218, 134, 122),
	},
	['Level9'] = {
		['LevelName'] = 'HyruleTowers',
		['Author'] = 'Brolervi',
		['Color'] = Color3.fromRGB(27, 42, 53),
	},
	['Level10'] = {
		['LevelName'] = 'TrumpWall',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(164, 189, 71),
	},
	['Level11'] = {
		['LevelName'] = 'OldTownRoad',
		['Author'] = 'LegendaryACS',
		['Color'] = Color3.fromRGB(33, 84, 185),
	},
	['Level12'] = {
		['LevelName'] = 'LastStartStairs',
		['Author'] = 'Brolervi',
		['Color'] = Color3.fromRGB(99, 95, 98),
	},
}

return Levels
