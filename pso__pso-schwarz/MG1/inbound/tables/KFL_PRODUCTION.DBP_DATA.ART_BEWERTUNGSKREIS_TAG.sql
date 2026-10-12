create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_BEWERTUNGSKREIS_TAG cluster by (
     MANDANT_ID,
     GLD,
     DAT_GLD 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BEWERTUNGSKREIS_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  ',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	DAT_GLD DATE NOT NULL COMMENT 'Datum, zu dem der GLD ermittelt wurde',
	PREIS_STEUER_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Preissteuerkennzeichen.S= S- Preis, V=GLD',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	GLD NUMBER(18,6) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden',
	STANDARD_PREIS NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S)',
	MENGE_BESTAND_BME NUMBER(18,3) NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten',
	WERT_BESTAND NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden',
	VK_WERT NUMBER(18,2) NOT NULL DEFAULT 0 COMMENT 'Zum Verkaufspreis bewerteter Bestand',
	ZEIT_EXTRAKT NUMBER(38,0) NOT NULL COMMENT 'Zeitpunkt der Erzeugung der Schnittstellendatei',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BEWERTUNGSKREIS_TAG primary key (MANDANT_ID, BEWERTUNGSKREIS_ID, ART_ID, DAT_GLD)
)COMMENT='TP408_LVS - Diese Tabelle bildet den gleitenden Durchschnittspreis aus der SAP Tabelle MBEW ab - nur für Läger - MULTISET'
;