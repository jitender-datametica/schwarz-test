/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_metric_client_item_variant_day
   generated from Powerdesigner on Dienstag, 3. Dezember 2024 19:26:19
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_DIG_METRIC_CLIENT_ITEM_VARIANT_DAY DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the metric in the NFPOW database.',
   ldl_dig_client_cd                   VARCHAR(100)     NOT NULL COMMENT 'Client code in the Lidl Digital DWH.',
   ldl_dig_item_variant_sid            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key prod_variant_sid in the source system. This column is necessary to provide a PK without leaving level of detail in the data.',
   cal_dt                              DATE             NOT NULL COMMENT 'Date of sales or return events in Lidl Digital before extract aggregation.',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item Number (not necessarily unique in this table - numbers can be reused if an item is cancelled, or multiple item instances will be created for catalog items).',
   ldl_dig_gtin_nr                     VARCHAR(100)     COMMENT 'EAN / GTIN number of the product variant as provided in the source at the time of extraction. The stored number sometimes contains special characters for Lidl Digital specific reasons.',
   metric_cnt                          NUMBER(38,0)     COMMENT 'Value of the metric if it is a counted number.',
   metric_qty                          NUMBER(38,5)     COMMENT 'Value of the metric if it is a quantity.',
   metric_val                          NUMBER(38,5)     COMMENT 'Value of the metric if it is an amount.',
   curr_cd                             VARCHAR(3)       COMMENT 'Lidl currencies.
            LDL: p_lew_core.t_currency.curr_iso_cd',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_DIG_METRIC_CLIENT_ITEM_VARIANT_DAY PRIMARY KEY (metric_type_id, ldl_dig_client_cd, ldl_dig_item_variant_sid, cal_dt) NOT ENFORCED 
)  COMMENT = 'Lidl Digital AV (Abverkauf) related metric data on the level web shop, Lidl Digital product variant and advertise day. These metrics are used to calculate certain KPIs including the percentage of items sold in a promotion (AVQ / sales quota).';
