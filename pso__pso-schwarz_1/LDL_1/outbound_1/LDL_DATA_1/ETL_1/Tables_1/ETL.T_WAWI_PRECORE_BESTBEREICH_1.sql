CREATE TABLE IF NOT EXISTS ldl_data_etl.t_wawi_precore_bestbereich_1 (
ctrcode STRING(3) NOT NULL,
bestbereichnr STRING(8) NOT NULL,
bestbereichbez STRING(35) NOT NULL,
mde_nr STRING(8) NOT NULL,
sofortdruck INTEGER,
gruppenwechsel INTEGER,
ausgabepdlk INTEGER,
datum DATETIME,
bediener STRING(8),
printer_no INTEGER,
delivery_note INTEGER,
plausibilitycheck INTEGER,
storageplcheck INTEGER,
order_stock INTEGER,
nullsetcheck STRING(1),
onlydeliverynote INTEGER,
usedbywamas INTEGER,
edelivery_note INTEGER,
ddelivery_note INTEGER,
order_scheme_active INTEGER,
order_scheme_group INTEGER,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);