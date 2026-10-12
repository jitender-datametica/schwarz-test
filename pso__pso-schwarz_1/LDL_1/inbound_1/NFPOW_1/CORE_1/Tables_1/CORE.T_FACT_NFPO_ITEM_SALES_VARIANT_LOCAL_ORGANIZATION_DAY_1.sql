/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_sales_variant_local_organization_day_1
   generated from Powerdesigner on Mittwoch, 5. Februar 2025 16:42:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ITEM_SALES_VARIANT_LOCAL_ORGANIZATION_DAY_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.',
   nfpo_gtin_nr                        VARCHAR(100)     NOT NULL COMMENT 'Assigned GTIN of one or more NFPO stock keeping units. A dummy_1 value is used to represent unknown variants of known items.',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key INTERNAL ORGANIZATION.',
   cal_dt                              DATE             NOT NULL COMMENT 'Calendar_1 date of the observation.',
   nfpo_adjust_sales_qty               NUMBER(38,5)     COMMENT 'Sales_1 quantity adjusted by returns.',
   nfpo_return_qty                     NUMBER(38,5)     COMMENT 'Return quantity.',
   nfpo_adjust_sales_net_euro_val      NUMBER(38,5)     COMMENT 'Net sales_1 value in euro adjusted by returns.',
   nfpo_adjust_sales_gross_euro_val    NUMBER(38,5)     COMMENT 'Gross sales_1 value in euro adjusted by returns.',
   nfpo_return_net_euro_val            NUMBER(38,5)     COMMENT 'Net return value in euro.',
   nfpo_return_gross_euro_val          NUMBER(38,5)     COMMENT 'Gross return value in euro.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',
   dwh_node_cd                         VARCHAR(20)      NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',   
   CONSTRAINT PK_T_FACT_NFPO_ITEM_SALES_VARIANT_LOCAL_ORGANIZATION_DAY PRIMARY KEY (nfpo_item_sid, nfpo_gtin_nr, nfpo_org_sid, cal_dt) NOT ENFORCED 
)  COMMENT = 'Aggregated fact table on the level item_1 sales_1 variant, local organization and calendar_1 day.';
