/* --------------------------------------------------------------------------------
   DDL for table: t_pos_receiptline_1
   generated from Powerdesigner on Dienstag, 16. Januar 2024 09:40:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_receiptline_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Filiale; FK auf LOCATION_1; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptline.store_id'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Verkaufs-Artikel_1; FK auf ITEM_1; SAP-CAR: z_ds_zpdx_tlogf.materialnumber; WAWI-DWH: t_ejr_receiptline.item_id'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Waehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_tlogf.transcurrency; WAWI-DWH: -'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Mengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-CAR: z_ds_zpdx_tlogf.salesuom; WAWI-DWH: -'),
main_item_grp_sid BIGNUMERIC(38,0) OPTIONS(description='MainItemGroup; FK auf MAINITEMGROUP;'),
item_grp_int_sid BIGNUMERIC(38,0) OPTIONS(description='ItemGroupInternational: FK auf ITEMGROUP_INTERNATIONAL'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptline.pos_terminal_id'),
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptline.orig_receipt_nr_ejr'),
receipt_dt DATE NOT NULL OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_receiptline.dat_formdate'),
receipt_tmsp DATETIME NOT NULL
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_receiptline.dat_formdate + time_receipt_ejr'),
receiptline_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer auf Bon; WAWI-DWH: t_ejr_receiptline.orig_receipt_serial_nr_ejr'),
transaction_type_cd STRING(20) NOT NULL OPTIONS(description='WAWI-DWH: t_ejr_receiptline.transactiontype_id'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_receiptline.timezone_cd'),
cashier_id BIGNUMERIC(38,0) OPTIONS(description='Kassierer(in); WAWI-DWH: t_ejr_receiptline.checker_id'),
cash_register_type_cd STRING(100) OPTIONS(description='The code identifying the register type.'),
authority_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Autorisierung - Code; WAWI-DWH: t_ejr_receiptline.authority_id'),
ean_barcode STRING(100) COLLATE 'und:ci' OPTIONS(description='EAN_1-Barcode; WAWI-DWH: t_ejr_receiptline.barcode'),
main_item_grp_cd STRING(20) OPTIONS(description='MainItemGroup; WAWI-DWH: t_ejr_receiptline.mainitemgrp_id'),
item_grp_int_cd STRING(20) OPTIONS(description='ItemGroupInternational; '),
weight_item_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen Gewichtsartikel; WAWI-DWH: t_ejr_receiptline.weight_item_fg'),
curr_cd STRING(20) OPTIONS(description='Waehrung - Code; SAP-CAR: transcurrency'),
turnover_relevant_fg BIGNUMERIC(38,0) OPTIONS(description='Umsatzrelevante Position; '),
sales_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine_1 Verkaufszeile (1=ja; 0=nein); case when transaction_type_cd in (100,101,102,103,170,172,180,182) then 1 else 0'),
deposit_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine_1 Pfandzeile (1=ja; 0=nein); case when transaction_type_cd in (120,121,122,123,220,221,222,223) then 1 else 0'),
item_unit_price NUMERIC(18,5)
OPTIONS(description='Stueck- bzw. Kilopreis; WAWI-DWH: t_ejr_receiptline.price_retail_ejr'),
item_unit_price_adjust NUMERIC(18,5)
OPTIONS(description='Stueck- bzw. Kilopreis inkl. Rabatt; WAWI-DWH: t_ejr_receiptline.price_retail_adjstd_ejr'),
sales_val NUMERIC(18,5)
OPTIONS(description='Artikelumsatz (=item_unit_price_adjust * sales_piece_qty bzw sales_weight_qty); WAWI-DWH: t_ejr_receiptline.val_retail_ejr'),
sales_orig_val NUMERIC(18,5)
OPTIONS(description='Artikelumsatz ohne Abzug des Rabatts (=item_unit_price * sales_piece_qty bzw sales_weight_qty); WAWI-DWH: t_ejr_receiptline.val_retail_orig_ejr'),
uom_cd STRING(20) OPTIONS(description='Masseinheit - Code; SAP-CAR: salesuom'),
sales_piece_qty NUMERIC(18,5)
OPTIONS(description='Artikelanzahl bei Stueckartikel, 1 bei Gewichtsartikel; WAWI-DWH: t_ejr_receiptline.qty_piece_ejr'),
sales_weight_qty NUMERIC(18,5)
OPTIONS(description='Gewicht in Gramm bei Gewichtsartikel; WAWI-DWH: t_ejr_receiptline.qty_weight_ejr'),
discount_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine_1 Rabattzeile (1=ja; 0=nein); case when transaction_type_cd in (401,402,441,442,601,602,641) then 1 else 0'),
discount_sid BIGNUMERIC(38,0) OPTIONS(description='Rabattgrund - Code; WAWI-DWH: t_ejr_receiptline.discount_id'),
discount_val NUMERIC(18,5) OPTIONS(description='gewaehrter Rabatt; WAWI-DWH: t_ejr_receiptline.val_discount_ejr'),
discount_base_val NUMERIC(18,5) OPTIONS(description='Originalpreis ohne Rabattierung; WAWI-DWH: val_discount_base_ejr'),
discount_weight_qty NUMERIC(18,5)
OPTIONS(description='Menge, auf die der Rabatt angewendet wird (fuer Gewichtsartikel); WAWI-DWH: qty_discount_pos_ejr'),
discount_piece_qty NUMERIC(18,5)
OPTIONS(description='Anzahl der Artikel_1, auf die der Rabatt angewendet wird (fuer Mengenartikel); WAWI-DWH: qty_discount_hq_ejr'),
vat_pct_val NUMERIC(18,5) OPTIONS(description='Mehrwertsteuer Prozentsatz; WAWI-DWH: t_ejr_receiptline.pct_vat_ejr'),
vat_val NUMERIC(18,5) OPTIONS(description='Mehrwertsteuerbetrag; WAWI-DWH: t_ejr_receiptline.val_vat_ejr'),
tax_class_cd STRING(20) OPTIONS(description='WAWI-DWH: t_ejr_receiptline.type_vat_ejr'),
item_scan_begin_tmsp DATETIME OPTIONS(description='WAWI-DWH: t_ejr_receiptline.timestamp_begin_ejr'),
item_scan_end_tmsp DATETIME OPTIONS(description='WAWI-DWH: t_ejr_receiptline.timestamp_end_ejr'),
item_entry_method_cd STRING(20)
OPTIONS(description='Artikel_1-Eingabemethode - Code; WAWI-DWH: t_ejr_receiptline.item_entry_method_cd_ejr'),
price_entry_method_cd STRING(20)
OPTIONS(description='Preis-Eingabemethode - Code; WAWI-DWH: t_ejr_receiptline.price_entry_method_cd_ejr'),
void_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine_1 Stornozeile (1=ja; 0=nein); case when transaction_type_cd in (171,173) then 1 else 0'),
receiptline_voided BIGNUMERIC(38,0)
OPTIONS(description='stornierte Bon-Zeile; WAWI-DWH: t_ejr_receiptline.parent_line_nr_ejr'),
receiptline_voided_by BIGNUMERIC(38,0)
OPTIONS(description='storniert durch Bon-Zeile; WAWI-DWH: t_ejr_receiptline.voided_by_line_nr_ejr'),
return_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine_1 Retourenzeile (1=ja; 0=nein); case when transaction_type_cd in (140,141,142,143) then 1 else 0'),
return_reason_cd STRING(20) OPTIONS(description='Rueckgabegrund; WAWI-DWH: t_ejr_receiptline.return_reason_cd_ejr'),
orig_receipt_store_id BIGNUMERIC(38,0)
OPTIONS(description='Filiale, in der der Artikel_1 ursprunglich verkauft wurde; WAWI-DWH: t_ejr_receiptline.original_orig_store_nr_ejr            '),
orig_receipt_register_id BIGNUMERIC(38,0)
OPTIONS(description='Kassennummer, an der der Artikel_1 urspruenglich verkauft wurde; WAWI-DWH: t_ejr_receiptline.original_pos_terminal_id_ejr'),
orig_receipt_dt DATE
OPTIONS(description='Bon-Datum, an dem der Artikel_1 urspruenglich verkauft wurde; WAWI-DWH: t_ejr_receiptline.original_dat_formdate_ejr'),
orig_receipt_id BIGNUMERIC(38,0)
OPTIONS(description='die Belegnummer als der Artikel_1 urspruenglich verkauft wurde; WAWI-DWH: t_ejr_receiptline.original_orig_receipt_nr_ejr'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='businessdaydate; WAWI-DWH: t_ejr_receiptline.dat_formdate'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, loc_sid, register_id, receipt_id, receipt_tmsp, receiptline_nr, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. SAP-CAR: /POSDW/TLOGF             z_ds_zpdx_tlogf;             WAWI: t_ejr_receiptline');