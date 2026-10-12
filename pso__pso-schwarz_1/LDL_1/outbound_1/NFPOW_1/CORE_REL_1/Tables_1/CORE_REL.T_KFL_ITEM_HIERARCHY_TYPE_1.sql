/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_hierarchy_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_hierarchy_type_1 (
kfl_item_hier_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the item_1 hierarchy_1 type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.ARTHIERTYP.ARTHIERTYP_ID'),
kfl_item_hier_type_descr STRING(250)
OPTIONS(description='name of the item_1 hierarchy_1 type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.ARTHIERTYP.ARTHIERTYP_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_item_hier_type_id) NOT ENFORCED
) OPTIONS(description='Kaufland item_1 hierarchy_1 type             KFL: DBP_DATA.ARTHIERTYP_1');