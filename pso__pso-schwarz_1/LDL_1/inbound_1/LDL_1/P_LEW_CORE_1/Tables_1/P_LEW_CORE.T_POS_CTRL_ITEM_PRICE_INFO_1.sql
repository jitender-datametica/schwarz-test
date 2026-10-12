/* --------------------------------------------------------------------------------
   DDL for table: t_pos_ctrl_item_price_info_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_CTRL_ITEM_PRICE_INFO_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_1; ',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1;',
   curr_sid                            NUMBER(38,0)     COMMENT 'Waehrung fuer die Preisangabe; FK auf CURRENCY',
   receipt_id                          NUMBER(38,0)     NOT NULL COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_price_info.orig_receipt_nr_ejr',
   receipt_dt                          DATE             COMMENT 'Bon-Datum; WAWI-DWH: t_ejr_price_info.dat_formdate',
   receipt_tmsp                        TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Bon-Zeitstempel; WAWI-DWH: t_ejr_price_info.dat_formdate + time_receipt_ejr',
   register_id                         NUMBER(38,0)     NOT NULL COMMENT 'Kassennummer; WAWI-DWH: t_ejr_price_info.pos_terminal_id',
   cashier_id                          NUMBER(38,0)     COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_price_info.checker_id',
   authority_cd                        VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Autorisierung - Code; WAWI-DWH: t_ejr_price_info.authority_id',
   timezone_id                         NUMBER(38,0)     COMMENT 'Zeitzone; WAWI-DWH: t_ejr_price_info.timezone_cd',
   transaction_begin_tmsp              TIMESTAMP_NTZ(9) COMMENT 'Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_price_info.timestamp_begin_ejr',
   transaction_end_tmsp                TIMESTAMP_NTZ(9) COMMENT 'Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_price_info.timestamp_end_ejr',
   transaction_type_cd                 VARCHAR(20)      COMMENT '; WAWI-DWH: t_ejr_price_info.transactiontype_id',
   curr_cd                             VARCHAR(20)      COMMENT 'Waehrung fuer die Preisangabe',
   retail_price_val                    NUMBER(18,5)     COMMENT 'Verkaufspreis des Artikels; WAWI-DWH: t_ejr_price_info.price_retail_ejr',
   item_takeover_fg                    NUMBER(38,0)     COMMENT 'Uebernahme des Artikels nach Aufruf (0=nein, 1=ja, der Artikel_1 wurde gekauft); WAWI-DWH: t_ejr_price_info.item_takeover_fg',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; ',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_CTRL_ITEM_PRICE_INFO PRIMARY KEY (client_id, loc_sid, item_sid, receipt_id, register_id, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ;
             SAP CAR: ;
             ELWIS: -
             WAWI: t_ejr_price_info';

