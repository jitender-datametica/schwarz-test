CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.t_fact_iot_setpoint_per_day_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
device_id STRING(50) COLLATE 'und:ci' NOT NULL,
supply_airtemp_meas NUMERIC(9,2),
return_airtemp_meas NUMERIC(9,2),
liquefactiontemp_meas NUMERIC(9,2),
liquefactiontemp_compound_meas NUMERIC(9,2),
temp_meas NUMERIC(9,2),
defrost_limittemp_meas NUMERIC(9,2),
lowtemp_meas NUMERIC(9,2),
td_update TIMESTAMP,
td_insert TIMESTAMP
);