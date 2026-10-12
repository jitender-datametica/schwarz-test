CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_receiptline_coupon_promotion_discount (
coupon_promo_sid BIGNUMERIC(38,0) OPTIONS(description='unique identifier of the coupon_promotion (surrogate key)'),
src_coupon_promo_nr STRING(100)
OPTIONS(description='identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Filiale; FK auf LOCATION; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptline.store_id'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Verkaufs-Artikel; FK auf ITEM; SAP-CAR: z_ds_zpdx_tlogf.materialnumber; WAWI-DWH: t_ejr_receiptline.item_id'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Waehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_tlogf.transcurrency; WAWI-DWH: -'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Mengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-CAR: z_ds_zpdx_tlogf.salesuom; WAWI-DWH: -'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptline.pos_terminal_id'),
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptline.orig_receipt_nr_ejr'),
receipt_dt DATE NOT NULL OPTIONS(description='Bon-Datum; WAWI-DWH: t_ejr_receiptline.dat_formdate'),
receipt_tmsp DATETIME
OPTIONS(description='Bon-Zeitstempel; WAWI-DWH: t_ejr_receiptline.dat_formdate + time_receipt_ejr'),
receiptline_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer auf Bon; WAWI-DWH: t_ejr_receiptline.orig_receipt_serial_nr_ejr'),
transaction_type_cd STRING(20) OPTIONS(description='WAWI-DWH: t_ejr_receiptline.transactiontype_id'),
timezone_id BIGNUMERIC(38,0) OPTIONS(description='Zeitzone; WAWI-DWH: t_ejr_receiptline.timezone_cd'),
ean_barcode STRING(100) COLLATE 'und:ci' OPTIONS(description='EAN-Barcode; WAWI-DWH: t_ejr_receiptline.barcode'),
main_item_grp_cd STRING(20) OPTIONS(description='MainItemGroup; WAWI-DWH: t_ejr_receiptline.mainitemgrp_id'),
weight_item_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen Gewichtsartikel; WAWI-DWH: t_ejr_receiptline.weight_item_fg'),
turnover_relevant_fg BIGNUMERIC(38,0) OPTIONS(description='Umsatzrelevante Position; '),
sales_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine Verkaufszeile (1=ja; 0=nein); case when transaction_type_cd in (100,101,102,103,170,172,180,182) then 1 else 0'),
deposit_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine Pfandzeile (1=ja; 0=nein); case when transaction_type_cd in (120,121,122,123,220,221,222,223) then 1 else 0'),
discount_sid BIGNUMERIC(38,0) OPTIONS(description='Rabattgrund - Code; WAWI-DWH: t_ejr_receiptline.discount_id'),
discount_val NUMERIC(18,5) OPTIONS(description='gewaehrter Rabatt; WAWI-DWH: t_ejr_receiptline.val_discount_ejr'),
discount_base_val NUMERIC(18,5) OPTIONS(description='Originalpreis ohne Rabattierung; WAWI-DWH: val_discount_base_ejr'),
discount_weight_qty NUMERIC(18,5)
OPTIONS(description='Menge, auf die der Rabatt angewendet wird (fuer Gewichtsartikel); WAWI-DWH: qty_discount_pos_ejr'),
discount_piece_qty NUMERIC(18,5)
OPTIONS(description='Anzahl der Artikel, auf die der Rabatt angewendet wird (fuer Mengenartikel); WAWI-DWH: qty_discount_hq_ejr'),
vat_pct_val NUMERIC(18,5) OPTIONS(description='Mehrwertsteuer Prozentsatz; WAWI-DWH: t_ejr_receiptline.pct_vat_ejr'),
vat_val NUMERIC(18,5) OPTIONS(description='Mehrwertsteuerbetrag; WAWI-DWH: t_ejr_receiptline.val_vat_ejr'),
tax_class_cd STRING(20) OPTIONS(description='WAWI-DWH: t_ejr_receiptline.type_vat_ejr'),
void_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine Stornozeile (1=ja; 0=nein); case when transaction_type_cd in (171,173) then 1 else 0'),
receiptline_voided BIGNUMERIC(38,0)
OPTIONS(description='stornierte Bon-Zeile; WAWI-DWH: t_ejr_receiptline.parent_line_nr_ejr'),
receiptline_voided_by BIGNUMERIC(38,0)
OPTIONS(description='storniert durch Bon-Zeile; WAWI-DWH: t_ejr_receiptline.voided_by_line_nr_ejr'),
return_fg BIGNUMERIC(38,0)
OPTIONS(description='Position ist eine Retourenzeile (1=ja; 0=nein); case when transaction_type_cd in (140,141,142,143) then 1 else 0'),
return_reason_cd STRING(20) OPTIONS(description='Rueckgabegrund; WAWI-DWH: t_ejr_receiptline.return_reason_cd_ejr'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='businessdaydate; WAWI-DWH: t_ejr_receiptline.dat_formdate'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')
)
OPTIONS(description='$Revision: 0000 $. table contains selected infromation from picked receiptlines related to the LidlPlus-Discount relevant Receiptline-Key\'s identified by LidlPlus pattern detection on src_discount_nr');