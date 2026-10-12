CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_app_session (
client_id BIGNUMERIC(38,0) NOT NULL,
app_session_sid BIGNUMERIC(38,0) NOT NULL,
src_ga_session_id BIGNUMERIC(38,0) NOT NULL,
src_app_id STRING(100),
src_user_pseudo_id STRING(250),
app_sid BIGNUMERIC(38,0) NOT NULL,
customer_sid BIGNUMERIC(38,0) NOT NULL,
app_session_start_tmsp DATETIME,
country_pol_sid BIGNUMERIC(38,0) NOT NULL,
country_pol_cd STRING(2) COLLATE 'und:ci' NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME,
dwh_updated DATETIME,
PRIMARY KEY (app_session_sid) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, app_session_sid;