/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_client_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_client_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_id
            CORE_REL: t_kfl_client.kfl_client_id'''),
kfl_client_cd STRING(100) NOT NULL
OPTIONS(description='''code of the KFL client (Mandant_1) in the Kaufland DWH, for example \'PL\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_kbez
            CORE_REL: t_kfl_client.kfl_client_cd'''),
kfl_client_name STRING(100) NOT NULL
OPTIONS(description='''name of the KFL client (Mandant_1) in the Kaufland DWH for example \'Polen\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_bez
            CORE_REL: t_kfl_client.kfl_client_name'''),
curr_cd STRING(3) NOT NULL
OPTIONS(description='''default currency code of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.default_wrg
            CORE_REL: t_kfl_client.curr_cd'''),
kfl_orig_client_id BIGNUMERIC(38,0)
OPTIONS(description='''original identifier of the KFL client (Mandant_1) in the Kaufland ERP system (SAP) Moldavia has a SAP instance together with Romania, therefors Moldavia uses the same id here
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_id_ursprung
            CORE_REL: t_kfl_client.kfl_orig_client_id'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id) NOT ENFORCED
)
OPTIONS(description='''Kaufland client (Mandant_1)
             KFL: KFL_PRODUCTION.DBP_DATA.MANDANT_1
             CORE_REL: T_KFL_CLIENT_1''');