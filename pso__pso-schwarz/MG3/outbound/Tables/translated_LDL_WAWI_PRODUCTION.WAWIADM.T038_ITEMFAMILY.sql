CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t038_itemfamily (
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
PRIMARY KEY (c038_family_id) NOT ENFORCED
);