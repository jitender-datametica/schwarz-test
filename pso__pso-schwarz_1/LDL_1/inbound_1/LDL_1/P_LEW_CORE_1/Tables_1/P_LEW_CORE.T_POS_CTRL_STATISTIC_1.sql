/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_statistic_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_CTRL_STATISTIC_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_1; ',
   register_id                         NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_statisticlist..till_nr',
   cashier_id                          NUMBER(38,0)     NOT NULL COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_statisticlist.cashier_id',
   cashier_status_id                   NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_statisticlist..cashier_status',
   statistic_id                        NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_statisticlist..stat_code',
   audit_nr                            NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_statisticlist..audit_nr',
   statistic_cnt                       NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_statisticlist..stat_count',
   statistic_val                       NUMBER(18,5)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_statisticlist..val_stat_amount',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; WAWI-DWH: t_ejr_statisticlist.dat_formdate',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_CTRL_STATISTIC PRIMARY KEY (client_id, loc_sid, register_id, cashier_id, statistic_id, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ;
             SAP CAR: ;
             ELWIS: -
             WAWI: t_ejr_statisticlist';

