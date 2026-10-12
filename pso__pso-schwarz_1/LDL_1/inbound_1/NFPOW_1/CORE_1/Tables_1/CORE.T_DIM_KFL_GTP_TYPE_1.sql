/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_gtp_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_GTP_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_gtp_type_id                     NUMBER(38,0)     NOT NULL COMMENT 'identifier of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.WUP_TYP.WUP_TYP_ID
            CORE_REL: t_kfl_gtp_type.kfl_gtp_type_id',
   kfl_gtp_type_name                   VARCHAR(100)     COMMENT 'name of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.WUP_TYP.WUP_TYP_BEZ
            CORE_REL: t_kfl_gtp_type.kfl_gtp_type_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_GTP_TYPE PRIMARY KEY (kfl_gtp_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland type of goods transshipment point (WUP_1)
             KFL: DBP_DATA.WUP_TYP_1
             CORE_REL: T_KFL_GTP_TYPE_1';

