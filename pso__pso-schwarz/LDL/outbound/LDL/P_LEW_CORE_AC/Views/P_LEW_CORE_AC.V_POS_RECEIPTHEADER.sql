CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pos_receiptheader (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), loc_sid
OPTIONS(description='Filiale; FK auf LOCATION; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptheader.store_id'),
curr_sid OPTIONS(description='Waehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_tlogf.transcurrency; WAWI-DWH: -'),
customer_sid OPTIONS(description='Surrogate Key CUSTOMER'), register_id
OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptheader.pos_terminal_id'), receipt_id
OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptheader.orig_receipt_nr_ejr'), receipt_dt
OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_receiptheader.dat_formdate'), receipt_tmsp
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_receiptheader.dat_formdate + time_receipt_ejr'),
transaction_type_cd OPTIONS(description='WAWI-DWH: t_ejr_receiptheader.transactiontype_id'), transaction_begin_tmsp
OPTIONS(description='Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_receiptheader.timestamp_begin_ejr'),
transaction_end_tmsp
OPTIONS(description='Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_receiptheader.timestamp_end_ejr'), timezone_id
OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_receiptheader.timezone_cd'), cashier_id
OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_receiptheader.checker_id'), cash_register_type_cd
OPTIONS(description='The code identifying the register type.'), authority_cd
OPTIONS(description='Autorisierung - Code; WAWI-DWH: t_ejr_receiptheader.authority_id'), self_scan_shopping_cart_nr
OPTIONS(description='Identifier of the virtual shopping cart in the self scan system.'), turnover_relevant_fg
OPTIONS(description='Umsatzrelevante Position; '), customer_cd
OPTIONS(description='Kundennummer, falls Kundenkarte verwendet; WAWI-DWH: t_ejr_receiptheader.customer_nr'),
lidlplus_customer_cd OPTIONS(description='LidlPlus-Kundennummer; used to infer customer_sid'), lidlplus_ident_type_cd
OPTIONS(description='LidlPlus Kundenidentifizierungsmethode'), cnt_receiptlines_total
OPTIONS(description='Anzahl Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_receiptline_ejr'), cnt_receiptlines_sales
OPTIONS(description='Anzahl Verkaufs-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_selling_position_ejr'),
cnt_receiptlines_discounts
OPTIONS(description='Anzahl Rabatt-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_discount_ejr'),
cnt_receiptlines_deposits
OPTIONS(description='Anzahl Pfand-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_deposit_ejr'),
cnt_receiptlines_returns
OPTIONS(description='Anzahl Retouren-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_return_ejr'),
cnt_receiptlines_voids OPTIONS(description='Anzahl Storno-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_void_ejr'),
cnt_receiptlines_turnover_relevant OPTIONS(description='Anzahl Umsatzrelevante Bon-Positionen; '), cnt_distinct_eans
OPTIONS(description='Anzahl unterschiedlicher EAN-Nummern; WAWI-DWH: t_ejr_receiptheader.cnt_ean_ejr'),
cnt_distinct_items
OPTIONS(description='Anzahl unterschiedlicher Artikel-Nummern; WAWI-DWH: t_ejr_receiptheader.cnt_item_ejr'),
cnt_distinct_item_grp_ints
OPTIONS(description='Anzahl unterschiedlicher IGI; WAWI-DWH: t_ejr_receiptheader.cnt_mainitemgroup_ejr'),
cnt_distinct_weight_items
OPTIONS(description='Anzahl unterschiedlicher Gewichtsartikel (gemessen an EAN); WAWI-DWH: t_ejr_receiptheader.cnt_item_weight_ejr'),
cnt_piece_qty
OPTIONS(description='Abverkaufsmenge der Gewichtsartikel in Stueck (=Summe ueber gesamt sales_weight_qty); WAWI-DWH: t_ejr_receiptheader.qty_piece_ejr'),
total_gross_val OPTIONS(description='Bon-Endsumme (brutto); WAWI-DWH: t_ejr_receiptheader.val_retail_ejr'),
total_net_val OPTIONS(description='Bon-Endsumme (netto); WAWI-DWH: t_ejr_receiptheader.val_retail_net_ejr'),
sales_gross_val OPTIONS(description='Bon-Umsatz (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_retail_pos_ejr'),
sales_net_val OPTIONS(description='Bon-Umsatz (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_retail_net_pos_ejr'),
deposit_gross_val OPTIONS(description='Pfandumsatz (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_deposit_ejr'),
deposit_net_val OPTIONS(description='Pfandumsatz (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_deposit_net_ejr'),
discount_gross_val OPTIONS(description='Rabattbetrag (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_discount_ejr'),
discount_net_val OPTIONS(description='Rabattbetrag (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_discount_net_ejr'),
dur_item_scan OPTIONS(description='Dauer Artikelscan; WAWI-DWH: t_ejr_receiptheader.dur_service_time_ejr'), dur_payment
OPTIONS(description='Dauer Bezahlvorgang; WAWI-DWH: t_ejr_receiptheader.dur_pay_change_time_ejr'),
resumed_receipt_store_id
OPTIONS(description='Filiale des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_store_id_ejr'),
resumed_receipt_register_id
OPTIONS(description='Kassennummer des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_terminal_id_ejr'),
resumed_receipt_id
OPTIONS(description='Bon-Nummer des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_receipt_nr_ejr'),
resumed_receipt_dt
OPTIONS(description='Datum des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_date_ejr'), dwh_cal_dt
OPTIONS(description='businessdaydate; WAWI-DWH: t_ejr_receiptheader.dat_dayend'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. SAP-CAR: /POSDW/TLOGFZ_DS_ZPDX_TLOGF;WAWI: T_EJR_RECEIPTHEADER`) AS SELECT
 client_id,
 loc_sid,
 curr_sid,
 customer_sid,
 register_id,
 receipt_id,
 receipt_dt,
 receipt_tmsp,
 transaction_type_cd,
 transaction_begin_tmsp,
 transaction_end_tmsp,
 timezone_id,
 cashier_id,
 cash_register_type_cd,
 authority_cd,
 self_scan_shopping_cart_nr,
 turnover_relevant_fg,
 customer_cd,
 lidlplus_customer_cd,
 lidlplus_ident_type_cd,
 cnt_receiptlines_total,
 cnt_receiptlines_sales,
 cnt_receiptlines_discounts,
 cnt_receiptlines_deposits,
 cnt_receiptlines_returns,
 cnt_receiptlines_voids,
 cnt_receiptlines_turnover_relevant,
 cnt_distinct_eans,
 cnt_distinct_items,
 cnt_distinct_item_grp_ints,
 cnt_distinct_weight_items,
 cnt_piece_qty,
 total_gross_val,
 total_net_val,
 sales_gross_val,
 sales_net_val,
 deposit_gross_val,
 deposit_net_val,
 discount_gross_val,
 discount_net_val,
 dur_item_scan,
 dur_payment,
 resumed_receipt_store_id,
 resumed_receipt_register_id,
 resumed_receipt_id,
 resumed_receipt_dt,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pos_receiptheader;