CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_revenue_accrual (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization to which the revenue is accrued.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country.)'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
accrual_dt DATE NOT NULL OPTIONS(description='The day when the the revenue was accrued'),
bus_dt DATE NOT NULL OPTIONS(description='The day for which the revenue is accrued.'),
curr_accrual_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record for the given key, i.e. the record with the latest accrual date. Filtering on this flag returns the revenue accruals after any corrections.'),
receipt_cnt INTEGER
OPTIONS(description='The number of receipts generated on this day in this internal organization (store).'),
turnover_net_val NUMERIC(29,5)
OPTIONS(description='The accrued net amount in the currency indicated by the currency code.'),
curr_cd STRING(3) OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, bus_dt, accrual_dt) NOT ENFORCED
)
OPTIONS(description='In the mid of the following month, the reconciled revenue for all days of the previous month is accrued to stores. The amounts resulting from cash register events are adjusted for commissions resulting from goods on consignment.');