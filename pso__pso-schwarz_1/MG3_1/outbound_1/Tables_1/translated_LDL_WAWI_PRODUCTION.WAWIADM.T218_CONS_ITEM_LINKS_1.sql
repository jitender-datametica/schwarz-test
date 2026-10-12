CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t218_cons_item_links_1 (
c218_id BIGNUMERIC(29,10) NOT NULL,
c218_itemno STRING(18),
c218_link_itemno STRING(18),
c218_relation_type_number INTEGER,
c218_casesize_factor NUMERIC(9,4),
c218_valid_from DATETIME,
c218_valid_until DATETIME,
c218_mod_user STRING(25),
c218_mod_date DATETIME,
scn INTEGER DEFAULT 0,
c218_self_scanning_flag INTEGER,
PRIMARY KEY (c218_id) NOT ENFORCED
);