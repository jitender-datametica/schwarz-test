/* --------------------------------------------------------------------------------
   DDL for table: t_pos_receiptheader
   generated from Powerdesigner on Samstag, 13. Dezember 2025 00:28:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_receiptheader (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Filiale; FK auf LOCATION; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptheader.store_id'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Waehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_tlogf.transcurrency; WAWI-DWH: -'),
customer_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CUSTOMER'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptheader.pos_terminal_id'),
receipt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptheader.orig_receipt_nr_ejr'),
receipt_dt DATE NOT NULL OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_receiptheader.dat_formdate'),
receipt_tmsp DATETIME
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_receiptheader.dat_formdate + time_receipt_ejr'),
transaction_type_cd STRING(20) OPTIONS(description='WAWI-DWH: t_ejr_receiptheader.transactiontype_id'),
transaction_begin_tmsp DATETIME
OPTIONS(description='Beginnzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_receiptheader.timestamp_begin_ejr'),
transaction_end_tmsp DATETIME
OPTIONS(description='Endzeitpunkt Bon-Bearbeitung; WAWI-DWH: t_ejr_receiptheader.timestamp_end_ejr'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_receiptheader.timezone_cd'),
cashier_id BIGNUMERIC(38,0) OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_receiptheader.checker_id'),
cash_register_type_cd STRING(100) OPTIONS(description='The code identifying the register type.'),
authority_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='Autorisierung - Code; WAWI-DWH: t_ejr_receiptheader.authority_id'),
self_scan_shopping_cart_nr STRING(100)
OPTIONS(description='Identifier of the virtual shopping cart in the self scan system.'),
turnover_relevant_fg BIGNUMERIC(38,0) OPTIONS(description='Umsatzrelevante Position; '),
customer_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='Kundennummer, falls Kundenkarte verwendet; WAWI-DWH: t_ejr_receiptheader.customer_nr'),
lidlplus_customer_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='LidlPlus-Kundennummer; used to infer customer_sid'),
lidlplus_ident_type_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='LidlPlus Kundenidentifizierungsmethode'),
cnt_receiptlines_total BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_receiptline_ejr'),
cnt_receiptlines_sales BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Verkaufs-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_selling_position_ejr'),
cnt_receiptlines_discounts BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Rabatt-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_discount_ejr'),
cnt_receiptlines_deposits BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Pfand-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_deposit_ejr'),
cnt_receiptlines_returns BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Retouren-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_return_ejr'),
cnt_receiptlines_voids BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Storno-Bon-Positionen; WAWI-DWH: t_ejr_receiptheader.cnt_void_ejr'),
cnt_receiptlines_turnover_relevant BIGNUMERIC(38,0) OPTIONS(description='Anzahl Umsatzrelevante Bon-Positionen; '),
cnt_distinct_eans BIGNUMERIC(38,0)
OPTIONS(description='Anzahl unterschiedlicher EAN-Nummern; WAWI-DWH: t_ejr_receiptheader.cnt_ean_ejr'),
cnt_distinct_items BIGNUMERIC(38,0)
OPTIONS(description='Anzahl unterschiedlicher Artikel-Nummern; WAWI-DWH: t_ejr_receiptheader.cnt_item_ejr'),
cnt_distinct_item_grp_ints BIGNUMERIC(38,0)
OPTIONS(description='Anzahl unterschiedlicher IGI; WAWI-DWH: t_ejr_receiptheader.cnt_mainitemgroup_ejr'),
cnt_distinct_weight_items BIGNUMERIC(38,0)
OPTIONS(description='Anzahl unterschiedlicher Gewichtsartikel (gemessen an EAN); WAWI-DWH: t_ejr_receiptheader.cnt_item_weight_ejr'),
cnt_piece_qty NUMERIC(18,5)
OPTIONS(description='Abverkaufsmenge der Gewichtsartikel in Stueck (=Summe ueber gesamt sales_weight_qty); WAWI-DWH: t_ejr_receiptheader.qty_piece_ejr'),
total_gross_val NUMERIC(18,5) OPTIONS(description='Bon-Endsumme (brutto); WAWI-DWH: t_ejr_receiptheader.val_retail_ejr'),
total_net_val NUMERIC(18,5)
OPTIONS(description='Bon-Endsumme (netto); WAWI-DWH: t_ejr_receiptheader.val_retail_net_ejr'),
sales_gross_val NUMERIC(18,5)
OPTIONS(description='Bon-Umsatz (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_retail_pos_ejr'),
sales_net_val NUMERIC(18,5)
OPTIONS(description='Bon-Umsatz (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_retail_net_pos_ejr'),
deposit_gross_val NUMERIC(18,5)
OPTIONS(description='Pfandumsatz (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_deposit_ejr'),
deposit_net_val NUMERIC(18,5)
OPTIONS(description='Pfandumsatz (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_deposit_net_ejr'),
discount_gross_val NUMERIC(18,5)
OPTIONS(description='Rabattbetrag (brutto) addiert; WAWI-DWH: t_ejr_receiptheader.val_discount_ejr'),
discount_net_val NUMERIC(18,5)
OPTIONS(description='Rabattbetrag (netto) addiert; WAWI-DWH: t_ejr_receiptheader.val_discount_net_ejr'),
dur_item_scan BIGNUMERIC(38,0)
OPTIONS(description='Dauer Artikelscan; WAWI-DWH: t_ejr_receiptheader.dur_service_time_ejr'),
dur_payment BIGNUMERIC(38,0)
OPTIONS(description='Dauer Bezahlvorgang; WAWI-DWH: t_ejr_receiptheader.dur_pay_change_time_ejr'),
resumed_receipt_store_id BIGNUMERIC(38,0)
OPTIONS(description='Filiale des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_store_id_ejr'),
resumed_receipt_register_id BIGNUMERIC(38,0)
OPTIONS(description='Kassennummer des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_terminal_id_ejr'),
resumed_receipt_id BIGNUMERIC(38,0)
OPTIONS(description='Bon-Nummer des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_receipt_nr_ejr'),
resumed_receipt_dt DATE
OPTIONS(description='Datum des Ursprungsbelegs; WAWI-DWH: t_ejr_receiptheader.resumed_trans_date_ejr'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='businessdaydate; WAWI-DWH: t_ejr_receiptheader.dat_dayend'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, register_id, receipt_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. SAP-CAR: /POSDW/TLOGF             z_ds_zpdx_tlogf;             WAWI: t_ejr_receiptheader');