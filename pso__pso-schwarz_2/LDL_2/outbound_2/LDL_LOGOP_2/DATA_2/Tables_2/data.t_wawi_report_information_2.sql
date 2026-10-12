CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_report_information_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
c1248_id BIGNUMERIC(38,0) NOT NULL,
c1248_timestamp DATETIME NOT NULL,
c1248_type STRING(200) NOT NULL,
c1248_key STRING(200) NOT NULL,
c1248_value STRING(16777216) NOT NULL,
scn BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, c1248_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T1248_REPORT_INFORMATION_2');