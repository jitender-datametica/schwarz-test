/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_audit_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_CTRL_AUDIT_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_2; ',
   register_id                         NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_auditlist.till_nr',
   cashier_id                          NUMBER(38,0)     NOT NULL COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_auditlist.cashier_id',
   cashier_status_id                   NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_auditlist.cashier_status',
   audit_type_id                       NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_auditlist..audit_code',
   audit_nr                            NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_auditlist.audit_nr',
   audit_cnt                           NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_auditlist.audit_count',
   audit_val                           NUMBER(18,5)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_auditlist.val_audit_amount',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; ',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_CTRL_AUDIT PRIMARY KEY (client_id, loc_sid, register_id, cashier_id, audit_type_id, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ;
             SAP CAR: ;
             ELWIS: -
             WAWI: t_ejr_auditlist';

