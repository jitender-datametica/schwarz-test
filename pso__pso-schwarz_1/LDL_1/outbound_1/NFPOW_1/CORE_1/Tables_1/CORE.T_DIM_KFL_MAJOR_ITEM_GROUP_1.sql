/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_major_item_group_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_major_item_group_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.MANDANT_ID            CORE_REL: t_kfl_major_item_group.kfl_client_id'),
kfl_major_item_grp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the major item_1 group (Oberwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.OWG_ID            CORE_REL: t_kfl_major_item_group.kfl_major_item_grp_id'),
kfl_main_item_grp_id BIGNUMERIC(38,0)
OPTIONS(description='identifier of the main item_1 group (Hauptwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_per.HWG_ID            CORE_REL: t_kfl_major_item_group_main_item_group.kfl_main_item_grp_id'),
kfl_department_id BIGNUMERIC(38,0)
OPTIONS(description='identifier of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.ABT_ID            CORE_REL: t_kfl_main_item_group_department.kfl_department_id'),
kfl_major_item_grp_name STRING(400) NOT NULL
OPTIONS(description='German name of the major item_1 group (Oberwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.OWG_BEZ            CORE_REL: t_kfl_major_item_group.kfl_major_item_grp_name'),
kfl_main_item_grp_name STRING(400) NOT NULL
OPTIONS(description='German name of the main item_1 group (Hauptwarengruppe) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.hwg_spr_zu.HWG_BEZ            CORE_REL: t_kfl_main_item_group.kfl_main_item_grp_name'),
kfl_department_name STRING(400)
OPTIONS(description='German name of the department (Abteilung) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_BEZ            CORE_REL: t_kfl_department.kfl_department_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_major_item_grp_id) NOT ENFORCED
)
OPTIONS(description='Kaufland major item_1 group (Oberwarengruppe, German names only)             KFL: DBP_DATA.OWG_SPR_ZU_1             CORE_REL: T_KFL_MAJOR_ITEM_GROUP_1');