/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_gtp_subsidiary_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_gtp_subsidiary_type_1 (
kfl_gtp_subsidiary_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.nb.NB_ID'),
kfl_gtp_subsidiary_type_name STRING(100)
OPTIONS(description='name of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.nb.NB_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_gtp_subsidiary_type_id) NOT ENFORCED
) OPTIONS(description='Kaufland subsidiary type (Nebenstellentyp)             KFL: DBP_DATA.NB_1');