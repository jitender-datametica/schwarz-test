CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_tcache_write_off_by_organization_day (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization where the write-off happened. This can be either a store or a delivery company. The type of internal organization is defined by the int_org_type_cd.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country.)'),
bus_dt DATE NOT NULL OPTIONS(description='The day to which the write-off is accrued.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
write_off_net_val NUMERIC(29,5) NOT NULL,
write_off_for_breakage_net_val NUMERIC(29,5) NOT NULL,
write_off_for_sell_by_dt_net_val NUMERIC(29,5) NOT NULL,
write_off_for_deliv_quality_net_val NUMERIC(29,5) NOT NULL,
write_off_for_defective_non_food_net_val NUMERIC(29,5) NOT NULL,
write_off_for_donations_net_val NUMERIC(29,5) NOT NULL,
write_off_for_discounts_net_val NUMERIC(29,5) NOT NULL,
write_off_for_taken_prod_net_val NUMERIC(29,5) NOT NULL,
write_off_for_force_majeure_net_val NUMERIC(29,5) NOT NULL,
write_off_for_stock_clearance_net_val NUMERIC(29,5) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);