/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COUPON_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 21. April 2022 10:06:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_coupon_2 (
coupon_id BIGNUMERIC NOT NULL OPTIONS(description='A business key that uniquely identifies a coupon'),
action_type STRING(100) NOT NULL
OPTIONS(description='Normalized values of field actions.type, Contains types of discount ("FREE_SHIPPING", "FIXED_DISCOUNT")'),
coupon_type STRING(100) OPTIONS(description='Text value describing coupon type'),
coupon_campaign_name STRING(100) OPTIONS(description='Nane- of the coupon promotion campaign'),
coupon_campaign_id STRING(50)
OPTIONS(description='A business key that uniquely identifies the promotion campaign to which this coupon belongs.'),
reason_id BIGNUMERIC OPTIONS(description='Identifier describing the reason for gifting the coupon'),
rule JSON OPTIONS(description='A JSON describing the conditions that must be satisfied so the coupon can be used.'),
actions JSON OPTIONS(description='A JSON describing what benefits the coupon provide'),
coupon_cd STRING(50) OPTIONS(description='A business key that uniquely identifies a coupon'),
coupon_start_date DATE
OPTIONS(description='The first date when this coupon can be used (date when the promotion begins)'),
coupon_end_date DATE OPTIONS(description='The last date when this coupon can be used (date when the promotion ends)'),
coupon_isfood_fg STRING(20) OPTIONS(description='Describes if the coupon can be used for food or non-food products'),
active BOOL OPTIONS(description='Flag that indicates if the coupon for this campaign is active'),
deleted BOOL OPTIONS(description='Flag that indicates if the coupon for this campaign is deleted'),
coupon_source STRING(20) OPTIONS(description='Source system providing the data'),
expired BOOL
OPTIONS(description='Flag indicatiing if the coupon is no longer valid and cannot be used in this campaign'),
discount_ship_fg BOOL OPTIONS(description='Flag that indicates if coupon offers discount of shipping cost'),
discount_buyx_payy_fg BOOL
OPTIONS(description='Flag that indicates if coupon allows you to buy X number of items at the price of Y items (ex. buy 3 for the price of 2)'),
discount_fixed_fg BOOL
OPTIONS(description='Flag that indicates if coupon offers discount of product cost - a fixed amount'),
discount_percentage_fg BOOL
OPTIONS(description='Flag that indicates if coupon offers discount of product cost as percentage of the price'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (coupon_id, action_type) NOT ENFORCED
) OPTIONS(description='The table contains raw source data for promotion coupons');