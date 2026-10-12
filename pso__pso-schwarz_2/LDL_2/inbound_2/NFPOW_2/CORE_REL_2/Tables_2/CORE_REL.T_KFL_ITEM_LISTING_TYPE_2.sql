/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_listing_type_2
   generated from Powerdesigner on Dienstag, 13. Mai 2025 09:57:03
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_LISTING_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the KFL client (Mandant_2) in the Kaufland DWH.
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN.MANDANT_ID',
   kfl_item_listing_type_cd            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the listing type for an item_2 in the Kaufland DWH. The listing type is similar to the promotion type but more detailed, for example "SP", "PN", "1" or "0".
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN.POSTEN_ID',
   kfl_item_listing_type_descr         VARCHAR(250)     COMMENT 'Short description of the listing type for an item_2 in the Kaufland DWH.
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN.POSTEN_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM_LISTING_TYPE PRIMARY KEY (kfl_client_id, kfl_item_listing_type_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland type of the item_2 listing, similar to promotion type, for example "SP", "PN", "1" or "0".
             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN_2';
