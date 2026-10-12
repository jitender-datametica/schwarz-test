CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.t_fact_iot_cold_location_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
device_id STRING(50) COLLATE 'und:ci' NOT NULL,
measurement_tm TIME NOT NULL,
supply_airtemp_meas NUMERIC(9,2),
return_airtemp_meas NUMERIC(9,2),
superheat_meas NUMERIC(9,2),
door_open_pct NUMERIC(9,2),
evaporator_active_qty NUMERIC(9,2),
cooling_active_pct NUMERIC(9,2),
temp_actual_meas NUMERIC(9,2),
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, cal_dt;