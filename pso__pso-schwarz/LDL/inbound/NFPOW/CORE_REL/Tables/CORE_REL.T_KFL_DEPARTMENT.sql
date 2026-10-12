/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_department
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_DEPARTMENT DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.MANDANT_ID',
   kfl_item_hier_type_id               NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item hierarchy type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ARTHIERTYP_ID',
   kfl_department_id                   NUMBER(38,0)     NOT NULL COMMENT 'identifier of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_ID',
   kfl_department_name                 VARCHAR(400)     COMMENT 'German name of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_DEPARTMENT PRIMARY KEY (kfl_client_id, kfl_item_hier_type_id, kfl_department_id) NOT ENFORCED 
)  COMMENT = 'Kaufland department (German names only)
             KFL: DBP_DATA.ABT_SPR_ZU';

