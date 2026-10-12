/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_payment_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_CTRL_PAYMENT_1 CLUSTER BY (
     CLIENT_ID,
     DWH_CAL_DT 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_1',
   curr_sid                            NUMBER(38,0)     COMMENT 'Waehrung, die grundsaetzlich fuer das Land_1 gilt (z.B. AT=>EUR)',
   curr_sid_alt                        NUMBER(38,0)     COMMENT 'Alternativ-Waehrung, mit der gezahlt wurde (z.B. AT erlaubt auch CHF)',
   turnover_relevant_fg                NUMBER(38,0)     NOT NULL,
   receipt_id                          NUMBER(38,0)     NOT NULL COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_payment.orig_receipt_nr_ejr',
   receipt_dt                          DATE             NOT NULL COMMENT 'Bon-Datum; WAWI-DWH: t_ejr_payment.dat_formdate',
   receipt_tmsp                        TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Bon-Zeitstempel; WAWI-DWH: t_ejr_payment.dat_formdate + time_receipt_ejr',
   timezone_id                         NUMBER(38,0)     COMMENT 'Zeitzone; WAWI-DWH: t_ejr_payment.timezone_cd',
   register_id                         NUMBER(38,0)     NOT NULL COMMENT 'Kassennummer; WAWI-DWH: t_ejr_payment.pos_terminal_id',
   receiptline_nr                      NUMBER(38,0)     NOT NULL COMMENT 'Laufende Nummer auf Bon; WAWI-DWH: t_ejr_payment.orig_receipt_serial_nr_ejr',
   transaction_type_cd                 VARCHAR(20)      COMMENT 'WAWI-DWH: t_ejr_payment.transactiontype_id',
   transaction_begin_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_payment.timestamp_begin_ejr',
   transaction_end_tmsp                TIMESTAMP_NTZ(9) COMMENT 'Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_payment.timestamp_end_ejr',
   cashier_id                          NUMBER(38,0)     COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_payment.checker_id',
   payment_method_id                   NUMBER(38,0)     COMMENT '; WAWI-DWH: t_ejr_payment.tendertype_id',
   payment_method_cd                   VARCHAR(20)      COMMENT 'SAP Code',
   tendertype_ejr_cd                   VARCHAR(20)      COLLATE 'en-ci' COMMENT '; WAWI-DWH: t_ejr_payment.tendertype_cd_ejr',
   payment_fg                          NUMBER(38,0)     COMMENT '; WAWI-DWH: t_ejr_payment.cnt_payment_ejr',
   curr_cd                             VARCHAR(20),
   payment_val                         NUMBER(18,5)     COMMENT 'Wert des Kaufs in Landes-/Storewaehrung; WAWI-DWH: t_ejr_payment.val_retail_payment_ejr',
   curr_cd_alt                         VARCHAR(20)      COMMENT '; WAWI-DWH: t_ejr_payment.currency_iso_cd',
   payment_alt_val                     NUMBER(18,5)     COMMENT 'Wert des Kaufs in alternativ erlaubter Waehrung, mit der auch gezahlt wurde; WAWI-DWH: t_ejr_payment.val_foreign_curr_ejr',
   diff_rounding_val                   NUMBER(18,5)     COMMENT '; WAWI-DWH: t_ejr_payment.val_diff_rounding_ejr',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; ',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_CTRL_PAYMENT PRIMARY KEY (client_id, loc_sid, receipt_id, receipt_dt, register_id, receiptline_nr, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ;
             SAP CAR: ;
             ELWIS: -
             WAWI: t_ejr_payment & t_ejr_payment_ntr';

