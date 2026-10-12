/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_gtin
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_GTIN DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.mandant_id',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item (Artikel) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.art_id',
   kfl_uom_cd                          VARCHAR(100)     NOT NULL,
   kfl_gtin_seq                        NUMBER(38,0)     NOT NULL,
   kfl_gtin_nr                         NUMBER(38,0)     NOT NULL COMMENT 'Global Trade Item Number (GTIN)
            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.gtin_id',
   kfl_main_gtin_fg                    BOOLEAN          NOT NULL COMMENT 'flag in the Kaufland DWH whether theGTIN is the main GTIN for the item
            KFL: KFL_PRODUCTION.DBP_DATA.art_gtin_zu.haupt_gtin_fg',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM_GTIN PRIMARY KEY (kfl_client_id, kfl_item_nr, kfl_uom_cd, kfl_gtin_seq) NOT ENFORCED 
)  COMMENT = 'Kaufland GTIN information for all items
             KFL: KFL_PRODUCTION.DBP_DATA.ART_GTIN_ZU';

