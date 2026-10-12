/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_name_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_name_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.mandant_id'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_1 (Artikel_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.art_id'),
kfl_item_name STRING(200)
OPTIONS(description='German name of the KFL item_1 (Artikel_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.art_bez'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_item_nr) NOT ENFORCED
) OPTIONS(description='Kaufland item_1 name             KFL: KFL_PRODUCTION.DBP_DATA.ART_SPR_ZU_1');