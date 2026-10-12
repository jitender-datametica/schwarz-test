/* --------------------------------------------------------------------------------
   DDL for table: t_cal_week
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_week (
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='YYYYKW; WAWI: x_data.t_cal_week.cy_week'),
cy_week_prev_1w BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAWI: x_data.t_cal_week.prev_week'),
cy_week_prev_1y BIGNUMERIC(38,0) OPTIONS(description='WAWI: x_data.t_cal_week.prev_cy_week'),
cy_week_prev_2y BIGNUMERIC(38,0) OPTIONS(description='WAWI: x_data.t_cal_week.preprev_cy_week'),
cy_week_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='(taglich berechnet); WAWI: x_data.t_cal_week.cy_week_sequence'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (cy_week) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. CWEE: Wochen;             WAWI: x_data.t_cal_week');