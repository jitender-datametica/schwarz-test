/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_register_transaction
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_CTRL_REGISTER_TRANSACTION CLUSTER BY (
     CLIENT_ID,
     DWH_CAL_DT 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION; ',
   receipt_id                          NUMBER(38,0)     NOT NULL COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_cntr_transact..orig_receipt_nr_ejr',
   receipt_dt                          DATE             NOT NULL COMMENT 'Bon-Datum; WAWI-DWH: t_ejr_cntr_transact..dat_formdate',
   receipt_tmsp                        TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Bon-Zeitstempel; WAWI-DWH: t_ejr_cntr_transact..dat_formdate + time_receipt_ejr',
   register_id                         NUMBER(38,0)     NOT NULL COMMENT 'Kassennummer; WAWI-DWH: t_ejr_cntr_transact..pos_terminal_id',
   cashier_id                          NUMBER(38,0)     COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_cntr_transact..checker_id',
   authority_cd                        VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Autorisierung - Code; WAWI-DWH: t_ejr_cntr_transact.authority_id',
   timezone_id                         NUMBER(38,0)     COMMENT 'Zeitzone; WAWI-DWH: t_ejr_cntr_transact..timezone_cd',
   transaction_begin_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_cntr_transact..timestamp_begin_ejr',
   transaction_end_tmsp                TIMESTAMP_NTZ(9) COMMENT 'Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_cntr_transact..timestamp_end_ejr',
   transaction_type_cd                 VARCHAR(20)      NOT NULL COMMENT '; WAWI-DWH: t_ejr_cntr_transact..transactiontype_id',
   transaction_type_detail_id          NUMBER(38,0)     NOT NULL COMMENT '; WAWI-DWH: t_ejr_cntr_transact.trans_detail_type_id',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; ',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_CTRL_REGISTER_TRANSACTION PRIMARY KEY (client_id, loc_sid, receipt_id, receipt_dt, register_id, transaction_type_cd, transaction_type_detail_id, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ;
             SAP CAR: ;
             ELWIS: -
             WAWI: t_ejr_cntr_transact';

