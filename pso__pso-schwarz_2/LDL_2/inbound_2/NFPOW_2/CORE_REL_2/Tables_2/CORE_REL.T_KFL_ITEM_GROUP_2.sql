/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_group_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_GROUP_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_spr_zu.MANDANT_ID',
   kfl_item_hier_type_id               NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item_2 hierarchy_2 type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_spr_zu.ARTHIERTYP_ID',
   kfl_item_grp_id                     NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item_2 group (Warengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_spr_zu.WG_ID',
   kfl_item_grp_name                   VARCHAR(400)     NOT NULL COMMENT 'German name of the item_2 group (Warengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_spr_zu.WG_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM_GROUP PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_item_grp_id) NOT ENFORCED 
)  COMMENT = 'Kaufland item_2 group (Warengruppe, German names only)
             KFL: DBP_DATA.WG_SPR_ZU_2';

