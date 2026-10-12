CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t244_contact_type_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c244_id INTEGER NOT NULL,
c244_desc_local STRING(50) NOT NULL,
c244_desc_int STRING(50) NOT NULL,
c244_validate INTEGER NOT NULL,
c244_wh_edit INTEGER NOT NULL,
c244_wh_read INTEGER NOT NULL,
c244_moduser STRING(20) NOT NULL,
c244_moddate DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c244_id, wh_nr) NOT ENFORCED
);