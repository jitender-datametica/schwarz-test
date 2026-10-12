/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_client (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_id'''),
kfl_client_cd STRING(100) NOT NULL
OPTIONS(description='''code of the KFL client (Mandant) in the Kaufland DWH, for example \'PL\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_kbez'''),
kfl_client_name STRING(100) NOT NULL
OPTIONS(description='''name of the KFL client (Mandant) in the Kaufland DWH for example \'Polen\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_bez'''),
curr_cd STRING(3) NOT NULL
OPTIONS(description='''default currency code of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.default_wrg'''),
kfl_orig_client_id BIGNUMERIC(38,0)
OPTIONS(description='''original identifier of the KFL client (Mandant) in the Kaufland ERP system (SAP) Moldavia has a SAP instance together with Romania, therefors Moldavia uses the same id here
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_id_ursprung'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id) NOT ENFORCED
) OPTIONS(description='''Kaufland client (Mandant)
             KFL: KFL_PRODUCTION.DBP_DATA.MANDANT''');