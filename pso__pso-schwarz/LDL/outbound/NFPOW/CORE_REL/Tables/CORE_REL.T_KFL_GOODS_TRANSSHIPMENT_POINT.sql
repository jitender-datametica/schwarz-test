/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_goods_transshipment_point
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_goods_transshipment_point (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wup.mandant_id'),
kfl_gtp_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_id'),
kfl_gtp_subsidiary_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wup.nb_id'),
kfl_country_cd STRING(100) NOT NULL
OPTIONS(description='ISO code of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wup.land_id'),
active_from_dt DATE
OPTIONS(description='begin date of the validity period of the GTP            KFL: KFL_PRODUCTION.DBP_DATA.wup.dat_von'),
active_to_dt DATE
OPTIONS(description='end date of the validity period of the GTP            KFL: KFL_PRODUCTION.DBP_DATA.wup.dat_bis'),
sales_from_dt DATE
OPTIONS(description='opening date of the market, e.g. the date when the market has ben opened for customers to buy products            KFL: KFL_PRODUCTION.DBP_DATA.wup.DAT_EROEFFNUNG'),
kfl_gtp_type_id BIGNUMERIC(38,0)
OPTIONS(description='identifier of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_typ_id'),
kfl_sales_gtp_name STRING(160)
OPTIONS(description='name of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH (sales department point of view)            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_name_v'),
kfl_purch_gtp_name STRING(160)
OPTIONS(description='name of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH (purchase department point of view)            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_name_e'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id) NOT ENFORCED
)
OPTIONS(description='Kaufland goods transshipment point (Warenumschlagsplatz / WUP)             KFL: KFL_PRODUCTION.DBP_DATA.WUP');