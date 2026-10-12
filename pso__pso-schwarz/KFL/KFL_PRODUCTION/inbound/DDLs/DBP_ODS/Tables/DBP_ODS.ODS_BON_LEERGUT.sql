create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_ODS.ODS_BON_LEERGUT cluster by (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
)(
	BON_ID VARCHAR(100) NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
	BON_ZEILE NUMBER(38,0) NOT NULL COMMENT 'Die Zeile des Bons',
	EAN_KASSE NUMBER(38,0) COMMENT 'Hier ist der Barcode des Leergutbons hinterlegt',
	UMSATZ_BRUTTO NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	START_BON_ZEILE TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
	BON_NR_EXTERN NUMBER(38,0) COMMENT 'Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	KPOS_ERFASSUNG_ID VARCHAR(40) COMMENT 'Erfassungsart: Manuell, Scan, etc.',
	MENGE NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Menge / Anzahl an Leergut',
	KL_ART_ID NUMBER(38,0) COMMENT 'Kaufland Artikelnummer',
	EINH_ID VARCHAR(12) COMMENT 'Einheit: Stueck, Kiste, etc.',
	MWST_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
	BARCODE_LEERGUT VARCHAR(100) COMMENT 'Barcode des Pfandzettels',
	constraint PK_ODS_BON_LEERGUT primary key (BON_ID, BON_DAT, MANDANT_ID, WUP_ID, BON_ZEILE)
)COMMENT='ODS -Leergutbons aus den Bonzeilen. Redundant gespeichert zur Steigerung der Performance. Alternativ wäre Join Index denkbar'
;
