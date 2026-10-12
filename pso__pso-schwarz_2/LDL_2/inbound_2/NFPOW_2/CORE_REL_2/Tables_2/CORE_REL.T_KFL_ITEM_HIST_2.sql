/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_hist_2
   generated from Powerdesigner on Dienstag, 13. Mai 2025 09:48:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_HIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the KFL client (Mandant_2) in the Kaufland DWH.
            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.MANDANT_ID',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the KFL item_2 (Artikel_2) in the Kaufland DWH.
            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.ART_ID',
   active_from_dt                      DATE             NOT NULL COMMENT 'Begin date of the validity_2 period of the KFL_ITEM_LISTING_TYPE_CD.
            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.DAT_VON',
   active_to_dt                        DATE             NOT NULL COMMENT 'End date of the validity_2 period of the KFL_ITEM_LISTING_TYPE_CD.
            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.DAT_BIS',
   kfl_item_listing_type_cd            VARCHAR(100)     COMMENT 'Identifier of the listing type for an item_2 in the Kaufland DWH. The listing type is similar to the promotion type but more detailed.
            KFL: KFL_PRODUCTION.DBP_DATA.ART_PER.POSTEN_ID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM_HIST PRIMARY KEY (kfl_client_id, kfl_item_nr, active_from_dt) NOT ENFORCED 
)  COMMENT = 'Kaufland item_2, historized version.
             KFL: KFL_PRODUCTION.DBP_DATA.ART_PER_2';
