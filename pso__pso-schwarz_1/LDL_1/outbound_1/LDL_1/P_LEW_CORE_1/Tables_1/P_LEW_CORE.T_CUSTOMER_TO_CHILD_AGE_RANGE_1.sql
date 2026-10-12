/* --------------------------------------------------------------------------------
   DDL for table: t_customer_to_child_age_range_1
   generated from Powerdesigner on Dienstag, 2. April 2024 17:23:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_to_child_age_range_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
child_age_range_cd STRING(100) NOT NULL
OPTIONS(description='Code of the age range in which the child is categorized depending on the age.'),
child_age_range_forecasted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag that indicates if the data used to compute child age range is real or forecasted. Flag = 1 (True) when child age range is forecasted.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (customer_sid, child_age_range_cd) NOT ENFORCED
)
OPTIONS(description='If a customer has household_type_id 2 or 3 this table defines the relationship between the customer and the child age ranges. If a customer has one or more children in each of the child age ranges one record will be inserted to show this relationship. A customer can be related to each of the child clusters. Contains only active relations from a customer to a child age range. Past relations get deleted when they are not active anymore.');