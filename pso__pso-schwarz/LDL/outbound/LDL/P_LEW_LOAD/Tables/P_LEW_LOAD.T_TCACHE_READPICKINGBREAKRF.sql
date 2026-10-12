CREATE OR REPLACE TABLE ldl_p_lew_load.t_tcache_readpickingbreakrf (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
lgnum STRING(100),
who BIGNUMERIC(38,0) NOT NULL,
work_package_sid BIGNUMERIC(38,0) NOT NULL,
enddate DATE,
endtime TIME,
startdate DATE,
starttime TIME,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);