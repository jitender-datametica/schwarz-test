/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_sales_variant_local_organization_day_1
   generated from Powerdesigner on Mittwoch, 5. Februar 2025 16:42:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_nfpo_item_sales_variant_local_organization_day_1 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key NFPO ITEM_1 INSTANCE.'),
nfpo_gtin_nr STRING(100) NOT NULL
OPTIONS(description='Assigned GTIN of one or more NFPO stock keeping units. A dummy_1 value is used to represent unknown variants of known items.'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key INTERNAL ORGANIZATION.'),
cal_dt DATE NOT NULL OPTIONS(description='Calendar_1 date of the observation.'),
nfpo_adjust_sales_qty BIGNUMERIC(38,5) OPTIONS(description='Sales_1 quantity adjusted by returns.'),
nfpo_return_qty BIGNUMERIC(38,5) OPTIONS(description='Return quantity.'),
nfpo_adjust_sales_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Net sales_1 value in euro adjusted by returns.'),
nfpo_adjust_sales_gross_euro_val BIGNUMERIC(38,5) OPTIONS(description='Gross sales_1 value in euro adjusted by returns.'),
nfpo_return_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Net return value in euro.'),
nfpo_return_gross_euro_val BIGNUMERIC(38,5) OPTIONS(description='Gross return value in euro.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (nfpo_item_sid, nfpo_gtin_nr, nfpo_org_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Aggregated fact table on the level item_1 sales_1 variant, local organization and calendar_1 day.');