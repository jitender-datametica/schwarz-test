/* --------------------------------------------------------------------------------
   DDL for table: t_tax_line
   generated from Powerdesigner on Mittwoch, 15. Mai 2024 12:00:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_tax_line (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number of the line in the retail event.'),
event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the tax calculation happened.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happend.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country.)'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
cash_register_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_type_cd STRING(20)
OPTIONS(description='The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)'),
cash_register_usg_type_cd STRING(20)
OPTIONS(description='The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.'),
cashier_hash STRING(32) NOT NULL
OPTIONS(description='The encrypted number of the cashier. (The hash is unique for a given store and a day.)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is valid for the given tax class. E.g. 19%'),
gross_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The gross amount for which VAT is calculated.'),
tax_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The resulting tax value.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='The VATsummary for a retail event. There is one tax line for each VAT class.');