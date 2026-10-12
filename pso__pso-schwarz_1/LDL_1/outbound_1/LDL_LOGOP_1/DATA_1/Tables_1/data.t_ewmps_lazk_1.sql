CREATE TABLE IF NOT EXISTS ldl_logop_data.t_ewmps_lazk_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lgnum)'),
mandt STRING(3) OPTIONS(description='Client'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
lazid_laznr STRING(5) NOT NULL OPTIONS(description='Warehouse area'),
lazbez STRING(200) OPTIONS(description='Warehouse area description.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, lazid_laznr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='SAP EWM PS - Warehouse area HEAD');