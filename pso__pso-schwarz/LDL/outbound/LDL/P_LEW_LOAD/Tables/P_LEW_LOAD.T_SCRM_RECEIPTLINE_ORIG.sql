CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_scrm_receiptline_orig (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Filiale; FK auf LOCATION; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptline.store_id'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kassennummer; WAWI-DWH: t_ejr_receiptline.pos_terminal_id'),
receipt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bon-Nummer; WAWI-DWH: t_ejr_receiptline.orig_receipt_nr_ejr'),
receiptline_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer auf Bon; WAWI-DWH: t_ejr_receiptline.orig_receipt_serial_nr_ejr'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='businessdaydate; WAWI-DWH: t_ejr_receiptline.dat_formdate'),
coupon_promo_sid BIGNUMERIC(38,0) OPTIONS(description='unique identifier of the coupon_promotion (surrogate key)'),
src_coupon_promo_nr STRING(100)
OPTIONS(description='identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id'),
src_discount_nr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='auf EJR befindliche Nachlassnummer (Business Key)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
receipt_tmsp DATETIME,
receiptline_voided BIGNUMERIC(38,0)
) CLUSTER BY dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. table contains receiptline key columns related to certain coupon_promotions which have been identified by SCRM');