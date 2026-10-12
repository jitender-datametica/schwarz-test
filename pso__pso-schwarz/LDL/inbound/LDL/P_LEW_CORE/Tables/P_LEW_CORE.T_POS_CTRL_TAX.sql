/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_tax
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_CTRL_TAX CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION; WAWI-DWH: t_ejr_tax.loc_sid',
   receipt_id                          NUMBER(38,0)     NOT NULL COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_tax.orig_receipt_nr_ejr',
   receipt_dt                          DATE             NOT NULL COMMENT 'Bon-Datum; WAWI-DWH: t_ejr_tax.dat_formdate',
   receipt_tmsp                        TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Bon-Zeitstempel; WAWI-DWH: t_ejr_tax.dat_formdate + time_receipt_ejr',
   register_id                         NUMBER(38,0)     NOT NULL COMMENT 'Kassennummer; WAWI-DWH: t_ejr_tax.pos_terminal_id',
   receiptline_nr                      NUMBER(38,0)     NOT NULL COMMENT 'Laufende Nummer auf Bon; WAWI-DWH: t_ejr_tax.orig_receipt_serial_nr_ejr',
   transaction_type_cd                 VARCHAR(20)      COMMENT '; WAWI-DWH: t_ejr_tax.transactiontype_id',
   timezone_id                         NUMBER(38,0)     COMMENT 'Zeitzone; WAWI-DWH: t_ejr_tax.timezone_cd',
   transaction_begin_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_tax.timestamp_begin_ejr',
   transaction_end_tmsp                TIMESTAMP_NTZ(9) COMMENT 'Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_tax.timestamp_end_ejr',
   cashier_id                          NUMBER(38,0)     COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_tax.checker_id',
   total_val                           NUMBER(18,5)     COMMENT 'Steuerpflichtiger Gesamtbetrag; WAWI-DWH: t_ejr_tax.val_vat_base_ejr',
   vat_val                             NUMBER(18,5)     COMMENT 'Ermittelter Steuerbetrag (Differenz Gesamtbetrag und Betrag ohne Steuer); WAWI-DWH: t_ejr_tax.val_vat_ejr',
   vat_pct_val                         NUMBER(18,5)     COMMENT 'verwendeter Steuersatz; WAWI-DWH: t_ejr_tax.pct_vat_ejr',
   tax_class_cd                        VARCHAR(20)      COMMENT '; WAWI-DWH: t_ejr_tax.type_vat_ejr; values->vat_sysmbol: (1->A,2->B,3->C,4->D)',
   tax_class_char_cd                   VARCHAR(20)      COMMENT '; WAWI-DWH: t_ejr_tax.vat_symbol',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; WAWI-DWH: t_ejr_tax.dat_formdate',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_CTRL_TAX PRIMARY KEY (client_id, loc_sid, receipt_id, receipt_dt, register_id, receiptline_nr, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ;
             SAP CAR: ;
             ELWIS: -
             WAWI: t_ejr_tax';

