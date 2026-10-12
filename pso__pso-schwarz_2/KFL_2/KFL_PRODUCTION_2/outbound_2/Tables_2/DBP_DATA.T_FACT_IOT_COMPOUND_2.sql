CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.t_fact_iot_compound_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
device_id STRING(50) COLLATE 'und:ci' NOT NULL,
measurement_tm TIME NOT NULL,
liquefactiontemp_actual_meas NUMERIC(9,2),
liquefactiontemp_setpoint_meas NUMERIC(9,2),
roomtemp_meas NUMERIC(9,2),
evaporationtemp_actual_meas NUMERIC(9,2),
evaporation_pressure_meas NUMERIC(9,2),
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, cal_dt;