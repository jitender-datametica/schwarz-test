create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_BEWERTUNGSKREIS_PER cluster by (dat_bis)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BEWERTUNGSKREIS_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt. Aus bwkey\n            \n            ',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Satz Gültigkeit hat',
	PREIS_STEUER_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Preissteuerkennzeichen.S= S- Preis, V=GLD. Aus vprsv',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM-TT\n            ',
	DAT_AENDERUNG DATE NOT NULL COMMENT 'Aenderungsdatum des Satzes im SAP Quellsystem.',
	ZEIT_AENDERUNG NUMBER(38,0) NOT NULL COMMENT 'Aenderungszeitpunkt des Satzes im Quellsystem.',
	GLD NUMBER(18,6) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden. Aus verpr',
	STANDARD_PREIS NUMBER(18,4) NOT NULL COMMENT 'Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S). Aus stprs',
	MENGE_BESTAND_BME NUMBER(18,3) NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten aus dem Quellfeld lbkum',
	WERT_BESTAND NUMBER(18,4) NOT NULL COMMENT 'Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden. Aus salk3',
	VK_WERT NUMBER(18,2) NOT NULL COMMENT 'Zum Verkaufspreis bewerteter Bestand aus vksal',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BEWERTUNGSKREIS_PER primary key (MANDANT_ID, BEWERTUNGSKREIS_ID, ART_ID, DAT_VON)
)COMMENT='TP2_AIS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Märkte - MULTISET'
;