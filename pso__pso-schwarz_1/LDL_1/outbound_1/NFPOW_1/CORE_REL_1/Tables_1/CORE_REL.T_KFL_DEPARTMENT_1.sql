/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_department_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_department_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.MANDANT_ID'),
kfl_item_hier_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the item_1 hierarchy_1 type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ARTHIERTYP_ID'),
kfl_department_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_ID'),
kfl_department_name STRING(400)
OPTIONS(description='German name of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_department_id) NOT ENFORCED
) OPTIONS(description='Kaufland department (German names only)             KFL: DBP_DATA.ABT_SPR_ZU_1');