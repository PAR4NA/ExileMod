class CfgMarXet
{
    class Database
    {
        /*
            The time in DAYS that a MarXet listing will sit in the database before it gets restricted.
            Restricted means that the seller's UID gets set to 0 so it's no longer owned by the player who sold it
            This keeps players from using MarXet as a long term storage device.
            This value must be LESS THAN the deleteTime
            Set this to -1 to disable
        */
        restrictTime = -1;

        /*
            The time in DAYS that a MarXet listing will stay in the database before it gets deleted
            This value only works if it's GREATER THAN the restrictTime.
            The listing must be restricted first before it can get deleted.
            Set this to -1 to disable
        */
        deleteTime = 15;
    };

    class Settings
    {
        /*
            Setting this to 1 will cause vehicles to spawn on preplaced Helipads.
            By default this option is 0 because servers will have to manually place the helipads
            Default (0) uses Exile's default position function
        */
        staticVehicleSpawning = 0;

        /* 
            All items in this list will not be allowed to list in the marketplace
        */
        blacklist[] = {
            "ItemCompass",
            "ItemMap",
            "Exile_Item_XM8",
            "ItemRadio",
			"Exile_Item_Matches",
			"Exile_Item_ExtensionCord",
			"ItemGPS",
			"Exile_Melee_Axe",
			"Exile_Magazine_Swing",
			"Exile_Item_CanOpener",
			"Exile_Item_EMRE",		
			"Exile_Item_GloriousKnakworst",
			"Exile_Item_Surstromming",
			"Exile_Item_SausageGravy",
			"Exile_Item_Catfood",
			"Exile_Item_MacasCheese",
			"Exile_Item_ChristmasTinner",
			"Exile_Item_BBQSandwich",
			"Exile_Item_Dogfood",
			"Exile_Item_BeefParts",
			"Exile_Item_Cheathas",
			"Exile_Item_DsNuts",
			"Exile_Item_Noodles",
			"Exile_Item_SeedAstics",
			"Exile_Item_Raisins",
			"Exile_Item_Moobar",
			"Exile_Item_CockONut",
			"Exile_Item_InstantCoffee",		
            "Exile_Item_PlasticBottleCoffee",
			"Exile_Item_PowerDrink",
			"Exile_Item_PlasticBottleFreshWater",
			"Exile_Item_Beer",
			"Exile_Item_EnergyDrink",
			"Exile_Item_ChocolateMilk",
			"Exile_Item_MountainDupe",
			"Exile_Item_PlasticBottleEmpty",
            "Exile_Uniform_BambiOverall",
			"Exile_Item_Flag",
			"Exile_Item_FlagStolen1",
			"Exile_Item_FlagStolen2",
			"Exile_Item_FlagStolen3",
			"Exile_Item_FlagStolen4",
			"Exile_Item_FlagStolen5",
			"Exile_Item_FlagStolen6",
			"Exile_Item_FlagStolen7",
			"Exile_Item_FlagStolen8",
			"Exile_Item_FlagStolen9",
			"Exile_Item_FlagStolen10",
			"Exile_Bike_OldBike",
			"Exile_Bike_MountainBike",
			"Exile_Bike_QuadBike_Black",
			"Exile_Bike_QuadBike_Blue",
			"Exile_Bike_QuadBike_White",
			"Exile_Bike_QuadBike_Fia",
			"H_Bandanna_camo",
			"V_Rangemaster_belt",
			"H_Cap_blk",
			"V_BandollierB_rgr",
			"B_AssaultPack_rgr",
			"hgun_P07_F",
			"H_Watchcap_blk",
			"V_BandollierB_blk",
			"B_AssaultPack_blk",
			"11Rnd_45ACP_Mag",
			"hgun_Pistol_heavy_01_F",
			"muzzle_snds_acp",
			"optic_MRD",
			"V_BandollierB_blk",
			"B_FieldPack_oli",
			"H_Bandanna_khk_hs",
			"G_Bandanna_oli",
			"Exile_Weapon_M1014",
			"B_FieldPack_blk",
			"hlc_smg_mp5sd5",
			"optic_Aco_smg",
			"B_TacticalPack_blk",
			"H_Cap_tan",
			"hlc_rifle_ak74",
			"HLC_Optic_1p29",
			"B_FieldPack_blk",
			"H_Cap_oli_hs",
			"hlc_rifle_CQBR",
			"hlc_muzzle_556NATO_KAC",
			"V_I_G_resistanceLeader_F",
			"H_Shemag_olive_hs",
			"arifle_MX_khk_F",
			"muzzle_snds_h_khk_f",
			"optic_ERCO_khk_F",
			"V_TacVest_khk",
			"B_Kitbag_cbr",
			"hlc_rifle_akm_MTK",
			"optic_MRCO",
			"V_PlateCarrierGL_rgr",
			"hlc_lmg_mk48",
			"optic_ERCO_blk_F",
			"muzzle_snds_B",
			"bipod_03_F_blk",
			"hgun_ACPC2_F",
			"muzzle_snds_acp",
			"H_Cap_blk",
			"H_Cap_blk_Raven",
			"H_Cap_blu",
			"H_Cap_brn_SPECOPS",
			"H_Cap_grn",
			"H_Cap_headphones",
			"H_Cap_khaki_specops_UK",
			"H_Cap_oli",
			"H_Cap_press",
			"H_Cap_red",
			"H_Cap_tan",
			"H_Cap_tan_specops_US",
			"H_Watchcap_blk",
			"H_Watchcap_camo",
			"H_Watchcap_khk",
			"H_Watchcap_sgg",
			"H_MilCap_blue",
			"H_MilCap_dgtl",
			"H_MilCap_mcamo",
			"H_MilCap_ocamo",
			"H_MilCap_oucamo",
			"H_MilCap_rucamo",
			"H_Bandanna_camo",
			"H_Bandanna_cbr",
			"H_Bandanna_gry",
			"H_Bandanna_khk",
			"H_Bandanna_khk_hs",
			"H_Bandanna_mcamo",
			"H_Bandanna_sgg",
			"H_Bandanna_surfer",
			"H_Booniehat_dgtl",
			"H_Booniehat_dirty",
			"H_Booniehat_grn",
			"H_Booniehat_indp",
			"H_Booniehat_khk",
			"H_Booniehat_khk_hs",
			"H_Booniehat_mcamo",
			"H_Booniehat_tan",
			"H_Hat_blue",
			"H_Hat_brown",
			"H_Hat_camo",
			"H_Hat_checker",
			"H_Hat_grey",
			"H_Hat_tan",
			"H_StrawHat",
			"H_StrawHat_dark",
			"H_Beret_02",
			"H_Beret_blk",
			"H_Beret_blk_POLICE",
			"H_Beret_brn_SF",
			"H_Beret_Colonel",
			"H_Beret_grn",
			"H_Beret_grn_SF",
			"H_Beret_ocamo",
			"H_Beret_red",
			"H_Shemag_khk",
			"H_Shemag_olive",
			"H_Shemag_olive_hs",
			"H_Shemag_tan",
			"H_ShemagOpen_khk",
			"H_ShemagOpen_tan",
			"H_TurbanO_blk",
			"H_HelmetB",
			"H_HelmetB_black",
			"H_HelmetB_camo",
			"H_HelmetB_desert",
			"H_HelmetB_grass",
			"H_HelmetB_light",
			"H_HelmetB_light_black",
			"H_HelmetB_light_desert",
			"H_HelmetB_light_grass",
			"H_HelmetB_light_sand",
			"H_HelmetB_light_snakeskin",
			"H_HelmetB_paint",
			"H_HelmetB_plain_blk",
			"H_HelmetB_sand",
			"H_HelmetB_snakeskin",
			"H_HelmetCrew_B",
			"H_HelmetCrew_I",
			"H_HelmetCrew_O",
			"H_HelmetIA",
			"H_HelmetIA_camo",
			"H_HelmetIA_net",
			"H_HelmetLeaderO_ocamo",
			"H_HelmetLeaderO_oucamo",
			"H_HelmetO_ocamo",
			"H_HelmetO_oucamo",
			"H_HelmetSpecB",
			"H_HelmetSpecB_blk",
			"H_HelmetSpecB_paint1",
			"H_HelmetSpecB_paint2",
			"H_HelmetSpecO_blk",
			"H_HelmetSpecO_ocamo",
			"H_CrewHelmetHeli_B",
			"H_CrewHelmetHeli_I",
			"H_CrewHelmetHeli_O",
			"H_HelmetCrew_I",
			"H_HelmetCrew_B",
			"H_HelmetCrew_O",
			"H_PilotHelmetHeli_B",
			"H_PilotHelmetHeli_I",
			"H_PilotHelmetHeli_O",
			"H_Helmet_Skate",
			"H_HelmetB_tna_F",
			"H_HelmetB_Enh_tna_F",
			"H_HelmetB_Light_tna_F",
			"H_HelmetSpecO_ghex_F",
			"H_HelmetLeaderO_ghex_F",
			"H_HelmetO_ghex_F",
			"H_HelmetCrew_O_ghex_F",
			"H_MilCap_tna_F",
			"H_MilCap_ghex_F",
			"H_Booniehat_tna_F",
			"H_Beret_gen_F",
			"H_MilCap_gen_F",
			"H_Cap_oli_Syndikat_F",
			"H_Cap_tan_Syndikat_F",
			"H_Cap_blk_Syndikat_F",
			"H_Cap_grn_Syndikat_F",
			"G_Spectacles",
			"G_Spectacles_Tinted",
			"G_Combat",
			"G_Lowprofile",
			"G_Shades_Black",
			"G_Shades_Green",
			"G_Shades_Red",
			"G_Squares",
			"G_Squares_Tinted",
			"G_Sport_BlackWhite",
			"G_Sport_Blackyellow",
			"G_Sport_Greenblack",
			"G_Sport_Checkered",
			"G_Sport_Red",
			"G_Tactical_Black",
			"G_Aviator",
			"G_Lady_Mirror",
			"G_Lady_Dark",
			"G_Lady_Red",
			"G_Lady_Blue",
			"G_Goggles_VR",
			"G_Balaclava_blk",
			"G_Balaclava_oli",
			"G_Balaclava_combat",
			"G_Balaclava_lowprofile",
			"G_Bandanna_blk",
			"G_Bandanna_oli",
			"G_Bandanna_khk",
			"G_Bandanna_tan",
			"G_Bandanna_beast",
			"G_Bandanna_shades",
			"G_Bandanna_sport",
			"G_Bandanna_aviator",
			"G_Shades_Blue",
			"G_Sport_Blackred",
			"G_Tactical_Clear",
			"G_Balaclava_TI_blk_F",
			"G_Balaclava_TI_tna_F",
			"G_Balaclava_TI_G_blk_F",
			"G_Balaclava_TI_G_tna_F",
			"G_Combat_Goggles_tna_F"
        };
    };
};