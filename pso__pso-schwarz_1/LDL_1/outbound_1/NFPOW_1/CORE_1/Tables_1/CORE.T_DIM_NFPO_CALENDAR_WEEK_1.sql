/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_calendar_week_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:42:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_calendar_week_1 (
cal_week BIGNUMERIC(38,0) NOT NULL,
nfpo_cal_week_name STRING(100) NOT NULL,
cal_week_begin_dt DATE NOT NULL,
cal_year BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_week) NOT ENFORCED
) OPTIONS(description='Comment 2Do');