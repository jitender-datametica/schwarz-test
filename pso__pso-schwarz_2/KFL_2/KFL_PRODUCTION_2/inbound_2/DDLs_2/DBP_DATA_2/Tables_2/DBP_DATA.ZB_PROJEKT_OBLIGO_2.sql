create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_OBLIGO_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BESTELL_BELEG_NR NUMBER(38,0) NOT NULL COMMENT 'Belegnummer der Bestellung auf die sich das Obligo bezieht.',
	BESTELL_BELEG_POS_NR NUMBER(38,0) NOT NULL COMMENT 'Belegposition der Bestellung auf die sich das Obligo bezieht.',
	DAT_BELEG DATE NOT NULL COMMENT 'Datum des Beleges für das Obligo.',
	KRK_ID VARCHAR(4) NOT NULL COMMENT 'globale ID des Kostenrechnungskreises',
	KOSTENART_ID VARCHAR(10) NOT NULL COMMENT 'Eindeutiger Fachschluessel fuer die Kostenarten',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_OBLIGO NUMBER(38,5) NOT NULL COMMENT 'Betrag des Obligo. Noch ausstehender Betrag zur Zahlung.',
	LOESCH_FG NUMBER(38,0) NOT NULL COMMENT 'Flag gibt an, ob Eintrag im Quellsystem wieder gelöscht wurde und nicht für das Reporting relevant ist.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_OBLIGO primary key (MANDANT_ID, BESTELL_BELEG_NR, BESTELL_BELEG_POS_NR, DAT_BELEG)
)COMMENT='Enthält das Obligo für die Bestellpositionen einer Bestellung. Unter Obligo versteht man die noch offenen Verbindlichkeiten.'
;
