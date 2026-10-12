CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_nps_quote_1 (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
cal_dt DATE NOT NULL OPTIONS(description='Report date'),
person_cnt_val BIGNUMERIC(38,5) OPTIONS(description='The number of persons that filled the survey'),
positive_cnt_val BIGNUMERIC(38,5) OPTIONS(description='The count of  positive surveys'),
negative_cnt_val BIGNUMERIC(38,5) OPTIONS(description='The count of  negative surveys'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, cal_dt) NOT ENFORCED
);