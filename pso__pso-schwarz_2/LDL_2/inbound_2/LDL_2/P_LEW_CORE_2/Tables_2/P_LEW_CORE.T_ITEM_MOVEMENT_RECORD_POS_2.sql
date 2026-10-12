/* --------------------------------------------------------------------------------
   DDL for table: t_item_movement_record_pos_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_MOVEMENT_RECORD_POS_2 CLUSTER BY (
     CLIENT_ID,
     DWH_CAL_DT 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_movement_record_year           NUMBER(38,0)     NOT NULL COMMENT 'Artikelbelegjahr; SAP-Retail: mkpf.mjahr; SAP-BW: t_bw_2lis_03_bf.mjahr',
   item_movement_record_id             NUMBER(20,0)     NOT NULL COMMENT 'Artikelbeleg; SAP-Retail: mkpf.mblnr; SAP-BW: t_bw_2lis_03_bf.mblnr',
   item_movement_record_pos_id         NUMBER(38,0)     NOT NULL COMMENT 'Position im Artikelbeleg; SAP-Retail: mseg.zeile; SAP-BW: t_bw_2lis_03_bf.zeile;',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: mseg.matnr; SAP-BW: t_bw_2lis_03_bf.matnr',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb (Niederlassung/Filiale); FK auf LOCATION_2; SAP-Retail: mseg.werks; SAP-BW: t_bw_2lis_03_bf.werks',
   loc_sid_counterparty                NUMBER(38,0)     COMMENT 'Kontrahent der Artikelbewegung: Empfangender/Abgebender Betrieb; FK auf LOCATION_2; SAP-Retail: mseg.umwrk; SAP-BW: t_bw_2lis_03_bf.umwrk',
   sup_sid                             NUMBER(38,0)     COMMENT '(Kontonummer des) Lieferanten; FK auf SUPPLIER_2; SAP-Retail: mseg.lifnr; SAP-BW: t_bw_2lis_03_bf.lifnr; ELWIS: t_s_itm_mov_record_pos.sup_sid',
   move_type_dtl_sid                   NUMBER(38,0)     COMMENT 'FK auf MOVEMENT TYPE DETAIL; SAP-Retail: mseg.(BWART,SOBKZ,KZBEW,KZZUG,KZVBR); SAP-BW: 2lis_03_bf.(BWART,KZBEW) SOBKZ="@", KZZUG="@", KZVBR="@"',
   comp_sid                            NUMBER(38,0)     COMMENT 'Verrechnender Buchungskreis; FK auf COMPANY; SAP-Retail: mseg.parbu; SAP-BW: t_bw_2lis_03_bf.bukrs; ELWIS: t_s_itm_mov_record_pos.company_sid',
   uom_sid_base                        NUMBER(38,0)     COMMENT 'Basismengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: mseg.meins; SAP-BW: t_bw_2lis_03_bf.meins; ELWIS: t_s_itm_mov_record_pos.base_qty_uom_sid',
   uom_sid_capt                        NUMBER(38,0)     COMMENT 'Erfassungsmengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: mseg.erfme; SAP-BW: t_bw_2lis_03_bf.erfme; ELWIS: t_s_itm_mov_record_pos.capt_uom_sid',
   curr_sid                            NUMBER(38,0)     COMMENT 'Waehrung; FK auf CURRENCY; SAP-Retail: mseg.WAERS; SAP-BW: t_bw_2lis_03_bf.WAERS; ELWIS: t_s_itm_mov_record_pos.curr_sid',
   order_record_id                     NUMBER(20,0)     COMMENT 'Einkaufsbeleg; FK auf ORDER RECORD POS; SAP-Retail: mseg.ebeln; SAP-BW: t_bw_2lis_03_bf.ebeln; ELWIS: t_s_itm_mov_record_pos.order_record_id',
   order_record_pos_id                 NUMBER(38,0)     COMMENT 'Positionsnummer des Einkaufsbelegs; FK auf ORDER RECORD POS; SAP-Retail: mseg.ebelp; SAP-BW: t_bw_2lis_03_bf.ebelp; ELWIS: t_s_itm_mov_record_pos.order_record_pos_id',
   storage_loc_cd                      VARCHAR(20)      COMMENT 'Lagerort; SAP-Retail: mseg.lgort; SAP-BW: t_bw_2lis_03_bf.lgort; ELWIS: t_s_itm_mov_record_pos.storage_loc_cd',
   uom_cd_base                         VARCHAR(20)      COMMENT 'Basismengeneinheit; SAP-Retail: mseg.meins; SAP-BW: t_bw_2lis_03_bf.meins; ELWIS: t_s_itm_mov_record_pos.base_qty_uom_sid',
   ship_qty                            NUMBER(18,5)     COMMENT 'Menge; SAP-Retail: mseg.menge; SAP-BW: t_bw_2lis_03_bf.menge; ELWIS: t_s_itm_mov_record_pos.ship_qty',
   complaint_record_id                 NUMBER(20,0)     COMMENT 'Reklamationsnummer; SAP-Retail: Berechnet aus mseg.sgtxt; SAP-BW: t_bw_2lis_03_bf.sgtxt; ELWIS: t_s_itm_mov_record_pos.cmpnt_record_id',
   complaint_record_pos_id             NUMBER(38,0)     COMMENT 'Reklamationspositionsnummer; SAP-Retail: Berechnet aus mseg.sgtxt; SAP-BW: t_bw_2lis_03_bf.sgtxt; ELWIS: t_s_itm_mov_record_pos.cmpnt_record_pos_id',
   uom_cd_capt                         VARCHAR(20)      COMMENT 'Erfassungsmengeneinheit; SAP-Retail: mseg.erfme; SAP-BW: t_bw_2lis_03_bf.erfme; ELWIS: t_s_itm_mov_record_pos.capt_uom_sid',
   capt_qty                            NUMBER(18,5)     COMMENT 'Menge in Erfassungsmengeneinheit; SAP-Retail: mseg.erfmg; SAP-BW: t_bw_2lis_03_bf.erfmg; ELWIS: t_s_itm_mov_record_pos.capt_qty',
   move_type_cd                        VARCHAR(20)      COMMENT 'Bewegungsart (Bestandsfuhrung); SAP-Retail: mseg.bwart; SAP-BW: t_bw_2lis_03_bf.bwart; ELWIS: t_s_itm_mov_record_pos.itm_mov_type_cd',
   move_reason_cd                      VARCHAR(20)      COMMENT 'Grund der Bewegung; SAP-Retail: mseg.grund; SAP-BW: t_bw_2lis_03_bf.grund; ELWIS: t_s_itm_mov_record_pos.itm_mov_reason_cd',
   deb_cred_cd                         VARCHAR(20)      COMMENT '(S)oll-/(H)aben-Kennz.; SAP-Retail: mseg.shkzg; SAP-BW: t_bw_2lis_03_bf.shkzg; ELWIS: t_s_itm_mov_record_pos.deb_cred_cd',
   ledger_account_cd                   VARCHAR(20)      COMMENT 'Sachkonto; SAP-Retail: mseg.sakto; SAP-BW: t_bw_2lis_03_bf.sakto; ELWIS: t_s_itm_mov_record_pos.ledger_account_nr',
   curr_cd                             VARCHAR(20)      COMMENT 'Waehrungscode; SAP-Retail: mseg.waers; SAP-BW: t_bw_2lis_03_bf.waers; ELWIS: t_s_itm_mov_record_pos.curr_sid',
   house_curr_net_purch_val            NUMBER(18,5)     COMMENT 'Einkaufsbetrag Netto in Hauswahrung; SAP-Retail: mseg.dmbtr; SAP-BW: t_bw_2lis_03_bf.dmbtr; ELWIS: t_s_itm_mov_record_pos.house_curr_val',
   net_purch_price_val                 NUMBER(18,5)     COMMENT 'Einkaufspreis in Netto; SAP-Retail: mseg.bwgeo; SAP-BW: t_bw_2lis_03_bf.bwgeo; ELWIS: t_s_itm_mov_record_pos.pur_net_val',
   net_sales_val                       NUMBER(18,5)     COMMENT 'Verkaufsbetrag in Netto; SAP-BW: t_bw_2lis_03_bf.bwgvo; ELWIS: t_s_itm_mov_record_pos.sales_net_val',
   gross_price_val                     NUMBER(18,5)     COMMENT 'Wert zu Verkaufspreisen mit Mehrwertsteuer; SAP-Retail: mseg.vkwrt; SAP-BW: t_bw_2lis_03_bf.vkwrt; ELWIS: t_s_itm_mov_record_pos.gross_val',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Buchungsdatum; SAP-Retail: mseg.budat_mkpf; SAP-BW: t_bw_2lis_03_bf.budat; ELWIS: booking_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_MOVEMENT_RECORD_POS PRIMARY KEY (client_id, item_movement_record_year, item_movement_record_id, item_movement_record_pos_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IMRP: Belegsegment Material; 
             SAP-Retail: mseg; 
             SAP-BW:  t_bw_2lis_03_bf;
             ELWIS: t_s_itm_mov_record_pos;';

