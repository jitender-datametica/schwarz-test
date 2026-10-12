CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_country_special_char_2 (
normal_char_list STRING(99) OPTIONS(description='Standard character list.'),
country_from_special_char_list STRING(99) NOT NULL OPTIONS(description='Special character list.'),
country_to_special_char_list STRING(99) NOT NULL OPTIONS(description='To normal character list.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS CREATED IN THE DATA WAREHOUSE.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='THE POINT IN TIME WHEN THIS RECORD WAS LAST UPDATED.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='THE UNIQUE IDENTIFIER OF THE BATCH LOAD WHICH HAS DONE THE LAST UPDATE TO THIS RECORD. (CLOSING A RECORD IN HISTORY WITHOUT UPDATING ANY PAYLOAD COLUMNS DOES NOT TRIGGER AN UPDATE OF THE DWH_LOAD_ID.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='THE CODE FOR THE SOURCE SYSTEM (OR SLICE OF SOURCE SYSTEM) FROM WHICH THIS RECORD WAS LOADED.'),
PRIMARY KEY (country_from_special_char_list, country_to_special_char_list) NOT ENFORCED
);