/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_gtin_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_gtin_2 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.mandant_id'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL item_2 (Artikel_2) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.art_id'),
kfl_uom_cd STRING(100) NOT NULL,
kfl_gtin_seq BIGNUMERIC(38,0) NOT NULL,
kfl_gtin_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Global Trade Item_2 Number (GTIN)            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.gtin_id'),
kfl_main_gtin_fg BOOL NOT NULL
OPTIONS(description='flag in the Kaufland DWH whether theGTIN is the main GTIN for the item_2            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.haupt_gtin_fg'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_item_nr, kfl_uom_cd, kfl_gtin_seq) NOT ENFORCED
) OPTIONS(description='Kaufland GTIN information for all items             KFL: KFL_PRODUCTION.DBP_DATA.ART_GTIN_ZU_2');