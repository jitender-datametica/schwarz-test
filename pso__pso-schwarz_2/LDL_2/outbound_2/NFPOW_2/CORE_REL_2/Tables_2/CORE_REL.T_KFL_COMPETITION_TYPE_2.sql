/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_competition_type_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_competition_type_2 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.MANDANT_ID'''),
kfl_competition_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the type of the competition in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.ALDI_ID'''),
kfl_competition_type_txt STRING(1000)
OPTIONS(description='''name of the type of the competition in the Kaufland DWH, for example \'Aldi Süd\' or \'Aldi komplett + Lidl\'
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.ALDI_BEZ'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_competition_type_id) NOT ENFORCED
)
OPTIONS(description='''Kaufland type of competition, for example "Aldi Süd" or "Aldi komplett + Lidl"
             KFL: DBP_DATA.ARTKZ_ALDI_2''');