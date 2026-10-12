/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.mandant_id',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item_2 (Artikel_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.art_id',
   kfl_vat_nr                          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the vat rate in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.mwst_id',
   kfl_negotiator_cd                   VARCHAR(100)     NOT NULL COMMENT 'identifier of the negotiator of the item_2 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.verhandler_id',
   kfl_home_brand_cd                   VARCHAR(100)     NOT NULL COMMENT 'identifier of the home brand_2 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.eigenmarke_id',
   kfl_season_nr                       VARCHAR(100)     COMMENT 'identifier of the season in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.saison_id',
   kfl_competition_type_id             NUMBER(38,0)     NOT NULL COMMENT 'identifier of the type of the competition in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.aldi_id',
   kfl_discount_item_fg                BOOLEAN          NOT NULL COMMENT 'flag in the Kaufland DWH whether the price label of the item_2 in the market is yellow or not, yellow means that the related price is on discount price level
            KFL: KFL_PRODUCTION.DBP_DATA.art.yellowprint_fg',
   kfl_bio_label_fg                    BOOLEAN          NOT NULL COMMENT 'sustainability label ''Biosiegel Flag EU'' in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.bio_fg',
   kfl_green_button_label_fg           BOOLEAN          NOT NULL COMMENT 'sustainability label ''Grüner Knopf'' in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.grk_fg',
   kfl_main_purch_mgr_nr               NUMBER(38,0)     NOT NULL COMMENT 'identifier of the central purchasing manager in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.zek_id',
   kfl_promo_item_type_cd              VARCHAR(100)     NOT NULL COMMENT 'current type of the promotion of an item_2 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.posten_kz_sap',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM PRIMARY KEY (kfl_client_id, kfl_item_nr) NOT ENFORCED 
)  COMMENT = 'Kaufland item_2
             KFL: KFL_PRODUCTION.DBP_DATA.ART_2';

