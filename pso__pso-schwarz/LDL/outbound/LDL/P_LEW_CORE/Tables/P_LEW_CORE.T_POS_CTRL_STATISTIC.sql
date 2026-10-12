/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_statistic
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_statistic (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION; '),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_statisticlist..till_nr'),
cashier_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_statisticlist.cashier_id'),
cashier_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_statisticlist..cashier_status'),
statistic_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_statisticlist..stat_code'),
audit_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_statisticlist..audit_nr'),
statistic_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_statisticlist..stat_count'),
statistic_val NUMERIC(18,5) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_statisticlist..val_stat_amount'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; WAWI-DWH: t_ejr_statisticlist.dat_formdate'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, register_id, cashier_id, statistic_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. ;             SAP CAR: ;             ELWIS: -             WAWI: t_ejr_statisticlist');