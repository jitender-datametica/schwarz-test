CREATE TABLE P_LEW_LOAD.T_SCRM_RECEIPTLINE_ORIG_1 CLUSTER BY (DWH_CAL_DT)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Filiale; FK auf LOCATION_1; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptline.store_id',
	REGISTER_ID NUMBER(38,0) NOT NULL COMMENT 'Kassennummer; WAWI-DWH: t_ejr_receiptline.pos_terminal_id',
	RECEIPT_ID NUMBER(38,0) NOT NULL COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_receiptline.orig_receipt_nr_ejr',
	RECEIPTLINE_NR NUMBER(38,0) NOT NULL COMMENT 'Laufende Nummer auf Bon; WAWI-DWH: t_ejr_receiptline.orig_receipt_serial_nr_ejr',
	DWH_CAL_DT DATE NOT NULL COMMENT 'businessdaydate; WAWI-DWH: t_ejr_receiptline.dat_formdate',
	COUPON_PROMO_SID NUMBER(38,0) COMMENT 'unique identifier of the coupon_promotion (surrogate key)',
	SRC_COUPON_PROMO_NR VARCHAR(100) COMMENT 'identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id',
	SRC_DISCOUNT_NR VARCHAR(100) NOT NULL COLLATE 'en-ci' COMMENT 'auf EJR befindliche Nachlassnummer (Business Key)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	RECEIPT_TMSP TIMESTAMP_NTZ(9),
	RECEIPTLINE_VOIDED NUMBER(38,0)
)COMMENT='$Revision: 0000 $. table contains receiptline key columns related to certain coupon_promotions which have been identified by SCRM'
;