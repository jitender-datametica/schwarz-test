CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_saphana_revenue_accrual_imdt_2 (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization to which the revenue is accrued.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
accrual_dt DATE NOT NULL OPTIONS(description='The day when the the revenue was accrued'),
bus_dt DATE NOT NULL OPTIONS(description='The day for which the revenue is accrued.'),
receipt_cnt INTEGER
OPTIONS(description='The number of receipts generated on this day in this internal organization (store).'),
turnover_net_val NUMERIC(29,5)
OPTIONS(description='The accrued net amount in the currency indicated by the currency code.'),
curr_cd STRING(3) OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
object_type STRING(3),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, bus_dt, accrual_dt) NOT ENFORCED
);