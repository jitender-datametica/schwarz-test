/* --------------------------------------------------------------------------------
   DDL for table: t_customer_hist_1
   generated from Powerdesigner on Dienstag, 2. April 2024 17:11:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Customer is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
lplus_geo_area_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the geographical area (surrogate key) the customer currently uses'),
lplus_geo_area_cd STRING(5) OPTIONS(description='code of the geographical area the customer currently uses'),
gender_cd STRING(5)
OPTIONS(description='The code for the gender of the customer. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.'),
age_range_cd STRING(100)
OPTIONS(description='Customers are organized in different groups of age ranges. This is the code for the age range the customer is assigned to. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.'),
household_type_id BIGNUMERIC(38,0)
OPTIONS(description='ID of the household type in which the customer lives. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.'),
household_type_forecasted_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag that indicates if the data used to compute the household type is real or forecasted. Flag = 1 (True) if the household type is forecasted. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (customer_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. A person that purchases goods (or services) from Lidl.              Typically, customers are not known in person, except when they identify themselves by using a loyalty card (e.g. LidlPlus) or purchasing online.');