create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_ODS.ELS_LEERGUT_POSITION (
	BARCODE_LEERGUT VARCHAR(100) NOT NULL COMMENT 'Barcode des Leergut-Bons',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
	BON_ZEILE NUMBER(38,0) NOT NULL COMMENT 'Zeilennummer - Kommt nicht aus Quelle',
	MWST_ID NUMBER(38,0) COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	KL_ART_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kaufland-Artikelnummer, sofern vorhanden',
	MENGE NUMBER(38,0) NOT NULL COMMENT 'Menge der Artikel',
	BON_ZEILEN_WERT NUMBER(38,4) NOT NULL DEFAULT 0 COMMENT 'Wert der Bonzeile',
	PLU_GRUPPE VARCHAR(20) COMMENT 'PLU Gruppe. Z.Bsp.: 100 = Mehrweg 19 %',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ELS_LEERGUT_POSITION primary key (BARCODE_LEERGUT, BON_ZEILE, MANDANT_ID)
)COMMENT='ELS - Positionsdaten von den am Pfandautomaten erstellten Leergutbons. Daten werden über SIB, SOLACE in Queue bereitgestellt.'
;
