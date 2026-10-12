CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_lidlplus_correction_receiptheader_log_1 (
client_id INTEGER NOT NULL,
yearmonth STRING(20) COLLATE 'und:ci',
wh_id INTEGER NOT NULL,
orig_store_nr INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
number_of_updated_rows INTEGER,
dwh_created DATETIME NOT NULL
);