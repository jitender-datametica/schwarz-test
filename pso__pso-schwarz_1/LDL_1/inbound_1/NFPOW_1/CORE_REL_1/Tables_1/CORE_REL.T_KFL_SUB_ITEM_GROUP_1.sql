/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_sub_item_group_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_SUB_ITEM_GROUP_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wug_spr_zu.MANDANT_ID',
   kfl_item_hier_type_id               NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item_1 hierarchy_1 type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wug_spr_zu.ARTHIERTYP_ID',
   kfl_sub_item_grp_id                 NUMBER(38,0)     NOT NULL COMMENT 'identifier of the sub item_1 group (Warenuntergruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wug_spr_zu.WUG_ID',
   kfl_item_grp_id                     NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item_1 group (Warengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wug_spr_zu.WG_ID',
   kfl_sub_item_grp_name               VARCHAR(160)     NOT NULL COMMENT 'German name of the sub item_1 group (Warenuntergruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wug_spr_zu.WUG_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_SUB_ITEM_GROUP PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_sub_item_grp_id, kfl_item_grp_id) NOT ENFORCED 
)  COMMENT = 'Kaufland sub item_1 group (Warenuntergruppe, German names only)
             KFL: DBP_DATA.WUG_SPR_ZU_1';

