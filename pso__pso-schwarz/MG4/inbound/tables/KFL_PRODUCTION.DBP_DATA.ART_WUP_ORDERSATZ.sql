create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_ORDERSATZ (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Betrieb',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer',
	DAT_VON DATE NOT NULL COMMENT 'Datum gültig ab',
	DAT_BIS DATE COMMENT 'Datum gültig bis',
	BEZUGSVORSCHRIFT_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Bezugsvorschrift',
	BEZUGSQUELLE_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Bezugsquelle',
	STATUS_F_AENDERUNGEN_FG NUMBER(38,0) NOT NULL COMMENT 'Statusfeld F-Änderungen',
	KDIS_ZZSOPOMVKE_FG NUMBER(38,0) NOT NULL COMMENT 'KDIS durch ZZSOPO-MVKE',
	KDIS_AUSLISTUNGSPROZESS_FG NUMBER(38,0) NOT NULL COMMENT 'KDIS aus Auslistungsprozess',
	ARCHIVIERUNGS_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Archivierungskennzeichen',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_ORDERSATZ primary key (MANDANT_ID, WUP_ID, NB_ID, ART_ID, DAT_VON)
)COMMENT='FLW - ZEK-Ordersatz - Pflege der Bezugswege auf Artikel-Markt-Ebene - SAP RET - ZEKORDERSATZ01'
;