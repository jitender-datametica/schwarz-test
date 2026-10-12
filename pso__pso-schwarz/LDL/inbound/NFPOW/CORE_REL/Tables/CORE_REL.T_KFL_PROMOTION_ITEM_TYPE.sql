/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_promotion_item_type
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_PROMOTION_ITEM_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.MANDANT_ID',
   kfl_promo_item_type_cd              VARCHAR(100)     NOT NULL COMMENT 'current type of the promotion of an item in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_KZ_SAP',
   kfl_promo_item_type_name            VARCHAR(100)     NOT NULL COMMENT 'German name of the current type of the promotion of an item in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_BEZ_SAP',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_PROMOTION_ITEM_TYPE PRIMARY KEY (kfl_client_id, kfl_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland type of promotion context for items
             KFL: DBP_DATA.POSTEN_KZ_SAP_SPR_ZU';

