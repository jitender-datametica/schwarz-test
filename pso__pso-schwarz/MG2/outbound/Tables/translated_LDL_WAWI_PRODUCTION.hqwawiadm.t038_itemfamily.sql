CREATE OR REPLACE TABLE ldl_wawi_production_hqwawiadm.t038_itemfamily (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
c038_family_id INTEGER NOT NULL,
c038_itemgrpnr INTEGER NOT NULL,
c038_prodgrpnr INTEGER NOT NULL,
c038_family_code INTEGER NOT NULL,
c038_desc_long STRING(120) NOT NULL,
c038_desc_short STRING(15),
c038_mod_date DATETIME,
c038_mod_user STRING(8),
c038_mmo_calculation_flag INTEGER NOT NULL,
c038_pst_print_flag INTEGER NOT NULL,
c038_mmo_modify_flag INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c038_family_id) NOT ENFORCED
);