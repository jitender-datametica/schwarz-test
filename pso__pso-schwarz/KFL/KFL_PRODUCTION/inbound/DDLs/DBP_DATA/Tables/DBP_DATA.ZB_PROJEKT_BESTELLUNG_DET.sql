create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_BESTELLUNG_DET (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BESTELL_BELEG_NR NUMBER(38,0) NOT NULL COMMENT 'Belegnummer der Bestellung.',
	BESTELL_BELEG_POS_NR NUMBER(38,0) NOT NULL COMMENT 'Nummer der Belegposition der Bestellung.',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BESTELL_BELEG_POS_TYP_CD VARCHAR(20) COMMENT 'Code der angibt, um welchen Positionstyp der Bestellung es sich handelt, bspw. N = Nachtrag.',
	DAT_ERSTELLUNG DATE COMMENT 'Erstelldatum der Belegposition.',
	MATERIAL_NR NUMBER(38,0) COMMENT 'Nummer des bestellten Materials.',
	WARENGRUPPE_CD VARCHAR(20) NOT NULL COMMENT 'Code der Warengruppe',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR für betrag_netto',
	BETRAG_NETTO NUMBER(38,5) NOT NULL COMMENT 'Nettobetrag der Bestellposition in Landeswährung',
	BETRAG_NETTO_KONZ NUMBER(38,5) COMMENT 'Nettobetrag der Bestellposition in Konzernwährung (EUR)',
	RATE_TAGESKURS NUMBER(38,5) COMMENT 'Rate für die Umrechnung der lokalen Währung zur Konzernwährung mit dem Tageskurs.',
	BESTELL_POS_TXT VARCHAR(500) COMMENT 'Freitext für die Belegposition.',
	ENDRECHNUNG_FG NUMBER(38,0) NOT NULL COMMENT 'Flag gibt an, ob ...............',
	LOESCH_FG NUMBER(38,0) NOT NULL COMMENT 'Flag gibt an, ob Belegposition gelöscht wurde und für das Reporting nicht relevant ist.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_BESTELLUNG_DET primary key (MANDANT_ID, BESTELL_BELEG_NR, BESTELL_BELEG_POS_NR)
)COMMENT='Enthält die Bestellpositionen der getätigten Bestellung für Projekte aus den Zentralbereichen.'
;
