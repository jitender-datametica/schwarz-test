/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_item_advertising_2
   generated from Powerdesigner on Dienstag, 3. Dezember 2024 19:26:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_DIG_ITEM_ADVERTISING_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_dig_adv_id                      NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the advertise campaign in the Lidl Digital DWH.',
   ldl_dig_item_variant_sid            NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the product variant in the Lidl Digital DWH.',
   ldl_dig_client_cd                   VARCHAR(100)     NOT NULL COMMENT 'Client code in the Lidl Digital DWH.',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item_2 Number (not necessarily unique in this table - numbers can be reused if an item_2 is cancelled, or multiple item_2 instances will be created for catalog items).',
   adv_status_cd                       VARCHAR(100)     NOT NULL COMMENT 'Status_2 of the advertising campaign.',
   adv_dt                              DATE             NOT NULL COMMENT 'Starting date of the advertising campaign in the extract from Lidl Digital.',
   adv_sales_reservation_start_dt      DATE             NOT NULL COMMENT 'Start date of the phase advertising campaign when customers can preorder the product, in the extract from Lidl Digital.',
   adv_sales_start_dt                  DATE             NOT NULL COMMENT 'Reference date of the advertising campaign to distinguish between regular orders and preorders, in the extract from Lidl Digital.',
   adv_sales_end_dt                    DATE             COMMENT 'End date of the phase of the advertising campaign when customers can order the item_2 using the conditions of the advertising campaign, in the extract from Lidl Digital.',
   adv_stock_qty                       NUMBER(38,5)     COMMENT 'Value of the metric if it is a quantity.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_DIG_ITEM_ADVERTISING PRIMARY KEY (ldl_dig_adv_id, ldl_dig_item_variant_sid) NOT ENFORCED 
)  COMMENT = 'Lidl Digital AVQ (Abverkaufsquote) related data on the level web shop, IAN (Lidl international article number) and advertise day. The dates are used to calculate the percentage of items sold in a promotion (AVQ / sales_2 quota).';
