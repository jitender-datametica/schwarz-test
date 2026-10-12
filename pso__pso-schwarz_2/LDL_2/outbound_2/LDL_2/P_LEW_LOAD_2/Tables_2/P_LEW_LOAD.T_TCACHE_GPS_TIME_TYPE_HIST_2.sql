CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_gps_time_type_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
time_type_sid BIGNUMERIC(38,0),
time_type_short_descr STRING(20) COLLATE 'und:ci',
time_type_descr STRING(100) COLLATE 'und:ci',
presence_fg BIGNUMERIC(38,0),
performance_relevant_fg BIGNUMERIC(38,0),
active_from_dt DATE,
active_to_dt DATE,
extraction_dt DATE,
extraction_ts DATETIME,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')
);