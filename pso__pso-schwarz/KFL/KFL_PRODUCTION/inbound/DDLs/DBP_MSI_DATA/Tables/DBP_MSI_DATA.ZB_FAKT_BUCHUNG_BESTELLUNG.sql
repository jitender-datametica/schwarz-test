create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.ZB_FAKT_BUCHUNG_BESTELLUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	WARENGRUPPE_CD VARCHAR(20) NOT NULL COMMENT 'Code der Warengruppe',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_BESTELLUNG_NETTO NUMBER(38,5) COMMENT 'Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NACHTRAG_NETTO NUMBER(38,5) COMMENT 'Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO NUMBER(38,5) COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG NUMBER(38,5) COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk',
	BETRAG_KOSTENPROGNOSE NUMBER(38,5) COMMENT 'Betrag der Kostenprognose in Landeswährung',
	BETRAG_ZEK NUMBER(38,5) COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEA NUMBER(38,5) COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_FAKT_BUCHUNG_BESTELLUNG primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, WARENGRUPPE_CD, GP_ID, WRG_TYP_ID)
)COMMENT='Faktentabelle für Buchungen die einer Bestellung zugeordnet werden können auf Ebene Projekt, Gewerk, Warengruppe, Lieferant.'
;
