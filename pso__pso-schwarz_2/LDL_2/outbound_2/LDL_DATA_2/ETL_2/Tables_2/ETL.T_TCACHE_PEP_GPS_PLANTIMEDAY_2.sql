CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_pep_gps_plantimeday_2 (
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
bic_zmlila STRING(20) NOT NULL,
wh_no STRING(20),
store BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
turnover NUMERIC(18,5),
totalhours NUMERIC(18,5),
productivity NUMERIC(18,5),
inventoryhours NUMERIC(18,5),
traininghours NUMERIC(18,5),
mischours NUMERIC(18,5),
lastmodification TIMESTAMP,
day_end_dat DATE,
extraction_tmsp TIMESTAMP NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);