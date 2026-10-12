/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_home_brand_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_home_brand_2 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.MANDANT_ID'),
kfl_home_brand_cd STRING(100) NOT NULL
OPTIONS(description='identifier of the home brand_2 of Kaufland in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_ID'),
kfl_home_brand_name STRING(160)
OPTIONS(description='German name of the home brand_2 of Kaufland in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_home_brand_cd) NOT ENFORCED
)
OPTIONS(description='Kaufland home brand_2 (German names only)             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_EIGENMARKE_2');