/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_main_item_group_department
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_MAIN_ITEM_GROUP_DEPARTMENT DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.MANDANT_ID',
   kfl_item_hier_type_id               NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item hierarchy type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.ARTHIERTYP_ID',
   kfl_main_item_grp_id                NUMBER(38,0)     NOT NULL COMMENT 'identifier of the main item group (Hauptwarengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.HWG_ID',
   kfl_department_id                   NUMBER(38,0)     NOT NULL COMMENT 'identifier of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.ABT_ID',
   active_from_dt                      DATE             NOT NULL COMMENT 'begin date of the validity period of the record
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.DAT_VON',
   active_to_dt                        DATE             COMMENT 'end date of the validity period of the record
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_per.DAT_BIS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_MAIN_ITEM_GROUP_DEPARTMENT PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_main_item_grp_id, kfl_department_id, active_from_dt) NOT ENFORCED 
)  COMMENT = 'Kaufland relation between main item group and department
             KFL: DBP_DATA.HWG_PER';

