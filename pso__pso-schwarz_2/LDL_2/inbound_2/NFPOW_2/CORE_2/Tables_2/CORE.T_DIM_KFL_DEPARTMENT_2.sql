/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_department_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_DEPARTMENT_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.MANDANT_ID
            CORE_REL: t_kfl_department.kfl_client_id',
   kfl_department_id                   NUMBER(38,0)     NOT NULL COMMENT 'identifier of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_ID
            CORE_REL: t_kfl_department.kfl_department_id',
   kfl_department_name                 VARCHAR(400)     COMMENT 'German name of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_BEZ
            CORE_REL: t_kfl_department.kfl_department_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_DEPARTMENT PRIMARY KEY (kfl_client_id, kfl_department_id) NOT ENFORCED 
)  COMMENT = 'Kaufland department (German names only)
             KFL: DBP_DATA.ABT_SPR_ZU_2
             CORE_REL: T_KFL_DEPARTMENT_2';

