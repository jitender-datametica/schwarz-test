CREATE OR REPLACE TABLE ldl_data_production_etl.t_rec_cnt_2 (
bus_dt DATE NOT NULL,
tbl_name STRING(100) NOT NULL,
tbl_rec_cnt INTEGER NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL,
PRIMARY KEY (bus_dt, tbl_name) NOT ENFORCED
);