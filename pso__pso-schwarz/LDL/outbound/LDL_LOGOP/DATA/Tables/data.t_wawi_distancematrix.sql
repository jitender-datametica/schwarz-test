CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_distancematrix (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
c1213_matrixid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary Key'),
c1213_gateid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gate ID from T1214_GATES'),
c1213_distance BIGNUMERIC(38,2) OPTIONS(description='Distance from gate to picking bin in meters'),
scn BIGNUMERIC(38,0),
c1213_pickingbinid BIGNUMERIC(38,0) OPTIONS(description='Picking Bin ID'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, c1213_matrixid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T1213_DISTANCEMATRIX');