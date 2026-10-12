/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_audit_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_ctrl_audit_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1; '),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_auditlist.till_nr'),
cashier_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_auditlist.cashier_id'),
cashier_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_auditlist.cashier_status'),
audit_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_auditlist..audit_code'),
audit_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_auditlist.audit_nr'),
audit_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_auditlist.audit_count'),
audit_val NUMERIC(18,5) NOT NULL OPTIONS(description='; WAWI-DWH: t_ejr_auditlist.val_audit_amount'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, register_id, cashier_id, audit_type_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. ;             SAP CAR: ;             ELWIS: -             WAWI: t_ejr_auditlist');