/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_name_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_NAME_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.mandant_id',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item_2 (Artikel_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.art_id',
   kfl_item_name                       VARCHAR(200)     COMMENT 'German name of the KFL item_2 (Artikel_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.art_bez',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM_NAME PRIMARY KEY (kfl_client_id, kfl_item_nr) NOT ENFORCED 
)  COMMENT = 'Kaufland item_2 name
             KFL: KFL_PRODUCTION.DBP_DATA.ART_SPR_ZU_2';

