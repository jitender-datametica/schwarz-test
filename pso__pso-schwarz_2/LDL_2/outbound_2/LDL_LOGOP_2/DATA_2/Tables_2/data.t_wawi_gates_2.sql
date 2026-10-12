CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_gates_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
wh_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'),
c1214_gateid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary Key'),
c1214_label STRING(200) NOT NULL OPTIONS(description='Label of the gate'),
c1214_allocationstateid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Status_2 ID from T1211_ALLOCATIONSTATES'),
c1214_info STRING(500) OPTIONS(description='Comment that is displayed in the application with the gate block.'),
c1214_updateuser STRING(50) OPTIONS(description='Username of the user who changed the gate status_2 last.'),
c1214_updatedatetime DATETIME OPTIONS(description='Time of the last status_2 change.'),
c1214_taskid BIGNUMERIC(38,0) OPTIONS(description='eGIN task ID if the gate has been blocked during gate calculation.'),
c1214_tourid BIGNUMERIC(38,0)
OPTIONS(description='TPP tour_2 ID if the gate has been blocked automatically by tour_2 status.'),
c1214_blockedbytour BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Manually unblocking an automatic tour_2 block sets this field to 0 effectively releasing the gate block. Prevents the same tour_2 from re_2-blocking.'),
scn BIGNUMERIC(38,0),
c1214_gateuuid STRING(16777216) OPTIONS(description='Default SYS_GUID. Used by the ALMA webservice'),
c1214_temperatureid BIGNUMERIC(38,0) OPTIONS(description='Was required for the WAMAS Areas'),
c1214_next_gate STRING(16777216) OPTIONS(description='Gives the order of the Gates'),
c1214_gioverlapping BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Decides the direction an overlapping assignment is possible. By default the value is 0.'),
c1214_groverlapping BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Decides the direction an overlapping assignment is possible. By default the value is 0.'),
c1214_areaid BIGNUMERIC(38,0) OPTIONS(description='Refers to the Table T1240_AREAS'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, c1214_gateid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T1214_GATES_2');