CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_POS_RECEIPTHEADER_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT'
  ,loc_sid                                  COMMENT 'Filiale; FK auf LOCATION_1; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptheader.store_id'
  ,curr_sid                                 COMMENT 'Waehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_tlogf.transcurrency; WAWI-DWH: -'
  ,customer_sid                             COMMENT 'Surrogate Key CUSTOMER'
  ,register_id                              COMMENT 'Kassennummer; WAWI-DWH: t_ejr_receiptheader.pos_terminal_id'
  ,receipt_id                               COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_receiptheader.orig_receipt_nr_ejr'
  ,receipt_dt                               COMMENT 'Bon-Datum; WAWI-DWH: t_ejr_receiptheader.dat_formdate'
  ,receipt_tmsp                             COMMENT 'Bon-Zeitstempel; WAWI-DWH: t_ejr_receiptheader.dat_formdate + time_receipt_ejr'
  ,transaction_type_cd                      COMMENT 'WAWI-DWH: t_ejr_receiptheader.transactiontype_id'
  ,transaction_begin_tmsp                   COMMENT 'Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_receiptheader.timestamp_begin_ejr'
  ,transaction_end_tmsp                     COMMENT 'Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_receiptheader.timestamp_end_ejr'
  ,timezone_id                              COMMENT 'Zeitzone; WAWI-DWH: t_ejr_receiptheader.timezone_cd'
  ,cashier_id                               COMMENT 'Kassierer(in); WAWI-DWH: t_ejr_receiptheader.checker_id'
  ,cash_register_type_cd                    COMMENT 'The code identifying the register type.'
  ,authority_cd                             COMMENT 'Autorisierung - Code; WAWI-DWH: t_ejr_receiptheader.authority_id'
  ,self_scan_shopping_cart_nr               COMMENT 'Identifier of the virtual shopping cart in the self scan system.'
  ,turnover_relevant_fg                     COMMENT 'Umsatzrelevante Position; '
  ,customer_cd                              COMMENT 'Kundennummer, falls Kundenkarte verwendet; WAWI-DWH: t_ejr_receiptheader.customer_nr'
  ,lidlplus_customer_cd                     COMMENT 'LidlPlus-Kundennummer; used to infer customer_sid'
  ,lidlplus_ident_type_cd                   COMMENT 'LidlPlus Kundenidentifizierungsmethode'
  ,cnt_receiptlines_total                   COMMENT 'Anzahl Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_receiptline_ejr'
  ,cnt_receiptlines_sales                   COMMENT 'Anzahl Verkaufs-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_selling_position_ejr'
  ,cnt_receiptlines_discounts               COMMENT 'Anzahl Rabatt-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_discount_ejr'
  ,cnt_receiptlines_deposits                COMMENT 'Anzahl Pfand-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_deposit_ejr'
  ,cnt_receiptlines_returns                 COMMENT 'Anzahl Retouren-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_return_ejr'
  ,cnt_receiptlines_voids                   COMMENT 'Anzahl Storno-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_void_ejr'
  ,cnt_receiptlines_turnover_relevant       COMMENT 'Anzahl Umsatzrelevante Bon-Positionen; '
  ,cnt_distinct_eans                        COMMENT 'Anzahl unterschiedlicher EAN_1-Nummern; WAWI-DWH: t_ejr_receiptheader.cnt_ean_ejr'
  ,cnt_distinct_items                       COMMENT 'Anzahl unterschiedlicher Artikel_1-Nummern; WAWI-DWH: t_ejr_receiptheader.cnt_item_ejr'
  ,cnt_distinct_item_grp_ints               COMMENT 'Anzahl unterschiedlicher IGI; WAWI-DWH: t_ejr_receiptheader.cnt_mainitemgroup_ejr'
  ,cnt_distinct_weight_items                COMMENT 'Anzahl unterschiedlicher Gewichtsartikel (gemessen an EAN_1); WAWI-DWH: t_ejr_receiptheader.cnt_item_weight_ejr'
  ,cnt_piece_qty                            COMMENT 'Abverkaufsmenge der Gewichtsartikel in Stueck (=Summe ueber gesamt sales_weight_qty); WAWI-DWH: t_ejr_receiptheader.qty_piece_ejr'
  ,total_gross_val                          COMMENT 'Bon-Endsumme (brutto); WAWI-DWH: t_ejr_receiptheader.val_retail_ejr'
  ,total_net_val                            COMMENT 'Bon-Endsumme (netto); WAWI-DWH: t_ejr_receiptheader.val_retail_net_ejr'
  ,sales_gross_val                          COMMENT 'Bon-Umsatz (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_retail_pos_ejr'
  ,sales_net_val                            COMMENT 'Bon-Umsatz (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_retail_net_pos_ejr'
  ,deposit_gross_val                        COMMENT 'Pfandumsatz (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_deposit_ejr'
  ,deposit_net_val                          COMMENT 'Pfandumsatz (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_deposit_net_ejr'
  ,discount_gross_val                       COMMENT 'Rabattbetrag (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_discount_ejr'
  ,discount_net_val                         COMMENT 'Rabattbetrag (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_discount_net_ejr'
  ,dur_item_scan                            COMMENT 'Dauer Artikelscan; WAWI-DWH: t_ejr_receiptheader.dur_service_time_ejr'
  ,dur_payment                              COMMENT 'Dauer Bezahlvorgang; WAWI-DWH: t_ejr_receiptheader.dur_pay_change_time_ejr'
  ,resumed_receipt_store_id                 COMMENT 'Filiale des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_store_id_ejr'
  ,resumed_receipt_register_id              COMMENT 'Kassennummer des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_terminal_id_ejr'
  ,resumed_receipt_id                       COMMENT 'Bon-Nummer des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_receipt_nr_ejr'
  ,resumed_receipt_dt                       COMMENT 'Datum des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_date_ejr'
  ,dwh_cal_dt                               COMMENT 'businessdaydate; WAWI-DWH: t_ejr_receiptheader.dat_dayend'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = '$Revision: 0000 $. SAP-CAR: /POSDW/TLOGF
z_ds_zpdx_tlogf;
WAWI: t_ejr_receiptheader'
AS SELECT
   client_id
  ,loc_sid
  ,curr_sid
  ,customer_sid
  ,register_id
  ,receipt_id
  ,receipt_dt
  ,receipt_tmsp
  ,transaction_type_cd
  ,transaction_begin_tmsp
  ,transaction_end_tmsp
  ,timezone_id
  ,cashier_id
  ,cash_register_type_cd
  ,authority_cd
  ,self_scan_shopping_cart_nr
  ,turnover_relevant_fg
  ,customer_cd
  ,lidlplus_customer_cd
  ,lidlplus_ident_type_cd
  ,cnt_receiptlines_total
  ,cnt_receiptlines_sales
  ,cnt_receiptlines_discounts
  ,cnt_receiptlines_deposits
  ,cnt_receiptlines_returns
  ,cnt_receiptlines_voids
  ,cnt_receiptlines_turnover_relevant
  ,cnt_distinct_eans
  ,cnt_distinct_items
  ,cnt_distinct_item_grp_ints
  ,cnt_distinct_weight_items
  ,cnt_piece_qty
  ,total_gross_val
  ,total_net_val
  ,sales_gross_val
  ,sales_net_val
  ,deposit_gross_val
  ,deposit_net_val
  ,discount_gross_val
  ,discount_net_val
  ,dur_item_scan
  ,dur_payment
  ,resumed_receipt_store_id
  ,resumed_receipt_register_id
  ,resumed_receipt_id
  ,resumed_receipt_dt
  ,dwh_cal_dt
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_POS_RECEIPTHEADER_1
;