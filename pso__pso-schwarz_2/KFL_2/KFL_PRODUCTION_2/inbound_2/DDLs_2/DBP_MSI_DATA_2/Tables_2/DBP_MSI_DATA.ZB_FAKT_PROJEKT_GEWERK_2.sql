create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.ZB_FAKT_PROJEKT_GEWERK_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KOSTENPROGNOSE NUMBER(38,5) COMMENT 'Betrag der der aktuellen Kostenprognose auf Ebene Projekt und Gewerk.',
	BETRAG_ZEK NUMBER(38,5) COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEA NUMBER(38,5) COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)',
	BETRAG_AKTUELLES_BUDGET NUMBER(38,5) COMMENT 'Betrag des aktuellen Budgets auf Ebene Projekt und Gewerk.',
	BETRAG_OBJEKTFREIGABE_BUDGET NUMBER(38,5) COMMENT 'Betrag des Budgets zum Zeitpunkt der Projektfreigabe auf Ebene Projekt und Gewerk.',
	BETRAG_VERTRAG NUMBER(38,5) COMMENT 'Betrag der Vertragswerte auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NETTO NUMBER(38,5) COMMENT 'Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NACHTRAG_NETTO NUMBER(38,5) COMMENT 'Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO NUMBER(38,5) COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG NUMBER(38,5) COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''K'' in dbp_data.zb_projekt_ist_kosten_2)',
	BETRAG_BAUKOSTENZUSCHUSS NUMBER(38,5) COMMENT 'Betrag der Baukostenzuschuesse auf Ebene Projekt und Gewerk (Kosten Typ CD = ''B'' in dbp_data.zb_projekt_ist_kosten_2)',
	BETRAG_FOERDERUNG NUMBER(38,5) COMMENT 'Betrag der Foerderungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''F'' in dbp_data.zb_projekt_ist_kosten_2)',
	BETRAG_RUECKSTELLUNG NUMBER(38,5) COMMENT 'Betrag der Rückstellungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''R'' in dbp_data.zb_projekt_ist_kosten_2)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_FAKT_PROJEKT_GEWERK primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, WRG_TYP_ID)
)COMMENT='Faktentabelle auf Ebene Projekt und Gewerk für Projektdaten aus den Zentralbereichen'
;
