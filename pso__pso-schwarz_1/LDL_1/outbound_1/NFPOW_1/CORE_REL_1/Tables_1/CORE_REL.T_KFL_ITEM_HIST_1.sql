/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_hist_1
   generated from Powerdesigner on Dienstag, 13. Mai 2025 09:48:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_item_hist_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the KFL client (Mandant_1) in the Kaufland DWH.            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.MANDANT_ID'),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the KFL item_1 (Artikel_1) in the Kaufland DWH.            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.ART_ID'),
active_from_dt DATE NOT NULL
OPTIONS(description='Begin date of the validity_1 period of the KFL_ITEM_LISTING_TYPE_CD.            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.DAT_VON'),
active_to_dt DATE NOT NULL
OPTIONS(description='End date of the validity_1 period of the KFL_ITEM_LISTING_TYPE_CD.            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.DAT_BIS'),
kfl_item_listing_type_cd STRING(100)
OPTIONS(description='Identifier of the listing type for an item_1 in the Kaufland DWH. The listing type is similar to the promotion type but more detailed.            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.POSTEN_ID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_item_nr, active_from_dt) NOT ENFORCED
) OPTIONS(description='Kaufland item_1, historized version.             KFL: KFL_PRODUCTION.DBP_DATA.ART_PER_1');