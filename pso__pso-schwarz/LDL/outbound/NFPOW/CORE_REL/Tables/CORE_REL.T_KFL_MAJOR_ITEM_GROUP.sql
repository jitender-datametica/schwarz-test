/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_major_item_group
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_major_item_group (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.MANDANT_ID'),
kfl_item_hier_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the item hierarchy type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.ARTHIERTYP_ID'),
kfl_major_item_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the major item group (Oberwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.OWG_ID'),
kfl_major_item_grp_name STRING(400) NOT NULL
OPTIONS(description='German name of the major item group (Oberwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.OWG_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_major_item_grp_id) NOT ENFORCED
)
OPTIONS(description='Kaufland major item group (Oberwarengruppe, German names only)             KFL: DBP_DATA.OWG_SPR_ZU');