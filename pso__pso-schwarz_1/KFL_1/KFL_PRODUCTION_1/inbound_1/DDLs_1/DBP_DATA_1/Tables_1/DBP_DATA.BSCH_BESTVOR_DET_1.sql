create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BSCH_BESTVOR_DET_1 cluster by (
     MANDANT_ID,
     DAT_PLAN 
)(
	BEST_VOR_NR NUMBER(18,0) NOT NULL COMMENT 'Bestellvorschlagsnummer, bei Bestellungen ohne Vorschlag die Bestellnummer aus der Tabelle besch_best_1',
	BEST_VOR_POS NUMBER(38,0) NOT NULL COMMENT 'Bestellvorschlagsposition',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_PLAN DATE NOT NULL COMMENT 'Planungsdatum',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige Artikelnummer',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	MENGE_BEST_VOR NUMBER(18,4) NOT NULL COMMENT 'Vorgeschlagene Menge',
	MENGE_BEST NUMBER(18,4) NOT NULL COMMENT 'Bestellte Menge',
	STATUS_1 VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Status_1 der Position: \n            \""VB\""  unveränderte Übernahme Vorschlag in Bestellung\n            \""V0\""  Vorschlag ohne Bestellung\n            \""0B\"" Bestellung ohne Vorschlag\n            \""V+\"" Bestellvorschlag erhöht\n            \""V-\"" Bestellvorschlag reduziert\n            ',
	BEST_VOR_EINH NUMBER(38,0) NOT NULL COMMENT 'Faktor zur vorgeschlagenen Menge, umgerechnet über art_umrechnung_fakor_per',
	BEST_EINH NUMBER(38,0) NOT NULL COMMENT 'Faktor zur bestellten Menge, umgerechnet über art_umrechnung_fakor_per',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	BESTELLART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' DEFAULT '    ' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	DAT_LIEF_SOLL DATE COMMENT 'Soll-Lieferdatum aus ZFRE_BV (fur_best_vor_1)',
	constraint PK_BSCH_BESTVOR_DET primary key (BEST_VOR_NR, BEST_VOR_POS, MANDANT_ID)
)COMMENT='AIS -  F&R - Aggregat der Bestellvorschläge - MULTISET  ab KW 19/12 entfällt die bisherige SST - wird jetzt aus der Tabelle fur_best_vor_1 befüllt'
;
