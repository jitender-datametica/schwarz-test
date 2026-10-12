/* --------------------------------------------------------------------------------
   DDL for table: t_discount_line_2
   generated from Powerdesigner on Dienstag, 11. März 2025 18:18:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_discount_line_2 (
retail_event_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_2 or return of products..'),
retail_event_line_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number of the line in the retail event. (Note that depending on the cash register software, this number is either a line number on the receipt or the sequence number of the discount which has been applied, so 1 for the first discount, 2 for the second discount and so on.)'),
discount_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In case several discounts are included in one receipt line, this is the sequence of the discounts.'),
discounted_line_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The line to which the discount was applied.'),
event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the discount was applied.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event is counted.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related retail event happened.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
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
auth_by_hash STRING(32)
OPTIONS(description='In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the encrypted number which identifies the employee_2, who has authorized the transaction. (The hash is unique for a given store and a day.)'),
cust_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
retail_event_line_scenario_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event line.'),
prod_variant_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the product variant (sales_2 variant), for which the discount was given,'),
wawi_item_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item_2 for which the discount was given.'),
discounted_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of products to which the discount was applied - in case the product is sold by piece.'),
discounted_qty BIGNUMERIC(38,5)
OPTIONS(description='The quantity of the product to which the discount was applied - in case the product is sold by weight.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_2 of measure.'),
discounted_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The base amount to which the discount has been applied. (in the currency indicated by the currency code)'),
discount_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The (gross) amount of the discount. (in the currency indicated by the currency code)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
discount_pct BIGNUMERIC(38,5) OPTIONS(description='The discount percentage which has been given.'),
discount_name STRING(100) OPTIONS(description='The name of the discount that is applied.'),
promo_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for a promotion.'),
discount_type_cd STRING(20)
OPTIONS(description='The code for kind of discount. It shows, if the price for the product was reduced, or if the product was free.'),
discount_reason_cd STRING(20)
OPTIONS(description='The code identifying the reason for a discount. A discount can be initiated by the cashier or triggered by a rule.'),
discount_calc_rule_cd STRING(20) OPTIONS(description='The code identifying the rule, how a discount is calculated.'),
cancel_line_seq BIGNUMERIC(38,0)
OPTIONS(description='In case the related product retail line is cancelled, then the discount line is cancelled, as well. This is the number of the related cancellation line.'),
split_fg BOOL
OPTIONS(description='An indicator showing, if the discount was given on receipt level and subsequently split across multiple receipt lines.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_sid, retail_event_line_seq, discount_seq, discounted_line_seq) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='A discount is a price reduction of an item_2 or a service. It may be given as a fix percent value, e.g. 10%, or it can be defined with more complex logic, e,g, 1€ discount for a LidlPlus customer, buy 3 pay 2, etc.');