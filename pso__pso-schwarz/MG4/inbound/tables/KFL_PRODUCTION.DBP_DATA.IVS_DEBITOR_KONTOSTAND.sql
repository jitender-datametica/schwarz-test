create or replace TABLE KFL_PRODUCTION.DBP_DATA.IVS_DEBITOR_KONTOSTAND (
	DEBITOR_ID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Debitors',
	ABZUG_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID fuer die Art und Zeitpunkt des Datenabzugs.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahr/Monat',
	BUCHUNGSKREIS_ID NUMBER(38,0) COMMENT 'SAP Buchungskreis',
	SONDERHAUPTBUCH_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Sonderhauptbuch Kennzeichen, momentan noch nicht befuellt.',
	SUMME_SOLL NUMBER(18,4) COMMENT 'Sollseite des Debitorkontos',
	SUMME_HABEN NUMBER(18,4) COMMENT 'Habenseite des Debitorkontos',
	SALDO_VORTRAG NUMBER(18,4) COMMENT 'Saldo Vortrag (Saldo zu Beginn der Periode), Saldo_Vortrag = Saldo Soll (Vorperiode) - Saldo Haben (Vorperiode)',
	SALDO_SOLL NUMBER(18,4) COMMENT 'Kontosaldo Sollseite',
	SALDO_HABEN NUMBER(18,4) COMMENT 'Kontosaldo Habenseite',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Waehrung',
	SALDO_KONTO NUMBER(18,4) COMMENT 'Gesamtsaldo des Kontos (Saldo Soll - Saldo Haben)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MIETVERTRAG_ID VARCHAR(20) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Entspricht mv_intreno aus IMMO',
	WUP_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Marktnummer'
)COMMENT='IVS - Kontostand des Debitors'
;