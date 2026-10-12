/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_client_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CLIENT_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_id
            CORE_REL: t_kfl_client.kfl_client_id',
   kfl_client_cd                       VARCHAR(100)     NOT NULL COMMENT 'code of the KFL client (Mandant_2) in the Kaufland DWH, for example ''PL''
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_kbez
            CORE_REL: t_kfl_client.kfl_client_cd',
   kfl_client_name                     VARCHAR(100)     NOT NULL COMMENT 'name of the KFL client (Mandant_2) in the Kaufland DWH for example ''Polen''
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_bez
            CORE_REL: t_kfl_client.kfl_client_name',
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'default currency code of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.default_wrg
            CORE_REL: t_kfl_client.curr_cd',
   kfl_orig_client_id                  NUMBER(38,0)     COMMENT 'original identifier of the KFL client (Mandant_2) in the Kaufland ERP system (SAP) Moldavia has a SAP instance together with Romania, therefors Moldavia uses the same id here
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_id_ursprung
            CORE_REL: t_kfl_client.kfl_orig_client_id',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CLIENT PRIMARY KEY (kfl_client_id) NOT ENFORCED 
)  COMMENT = 'Kaufland client (Mandant_2)
             KFL: KFL_PRODUCTION.DBP_DATA.MANDANT_2
             CORE_REL: T_KFL_CLIENT_2';

