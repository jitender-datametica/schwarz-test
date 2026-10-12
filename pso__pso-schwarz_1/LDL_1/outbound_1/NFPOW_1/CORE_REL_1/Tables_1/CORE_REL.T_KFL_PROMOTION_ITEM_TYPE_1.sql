/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_promotion_item_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_promotion_item_type_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.MANDANT_ID'),
kfl_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='current type of the promotion of an item_1 in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_KZ_SAP'),
kfl_promo_item_type_name STRING(100) NOT NULL
OPTIONS(description='German name of the current type of the promotion of an item_1 in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_BEZ_SAP'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_promo_item_type_cd) NOT ENFORCED
) OPTIONS(description='Kaufland type of promotion context for items             KFL: DBP_DATA.POSTEN_KZ_SAP_SPR_ZU_1');