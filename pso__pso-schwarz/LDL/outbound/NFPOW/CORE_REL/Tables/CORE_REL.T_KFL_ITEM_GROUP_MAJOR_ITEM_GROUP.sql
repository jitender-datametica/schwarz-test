/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_group_major_item_group
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_group_major_item_group (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.MANDANT_ID'),
kfl_item_hier_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the item hierarchy type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.ARTHIERTYP_ID'),
kfl_item_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the item group (Warengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.WG_ID'),
kfl_major_item_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the major item group (Oberwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.OWG_ID'),
kfl_department_id BIGNUMERIC(38,0)
OPTIONS(description='identifier of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.ABT_ID'),
active_from_dt DATE NOT NULL
OPTIONS(description='begin date of the validity period of the record            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.DAT_VON'),
active_to_dt DATE
OPTIONS(description='end date of the validity period of the record            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.DAT_BIS'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_item_grp_id, kfl_major_item_grp_id, active_from_dt) NOT ENFORCED
) OPTIONS(description='Kaufland relation between item group and major item group             KFL: DBP_DATA.WG_PER');