create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_BEWERTUNGSKREIS_MONAT_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BEWERTUNGSKREIS_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  ',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	GJMO NUMBER(38,0) NOT NULL COMMENT 'Geschäftsjahresmonat',
	PREIS_STEUER_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Preissteuerkennzeichen.S= S- Preis, V=GLD',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	GLD NUMBER(18,6) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände',
	STANDARD_PREIS NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S)',
	MENGE_BESTAND_BME NUMBER(18,3) NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten',
	WERT_BESTAND NUMBER(18,4) NOT NULL COMMENT 'Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden',
	VK_WERT NUMBER(18,2) NOT NULL COMMENT 'Zum Verkaufspreis bewerteter Bestand',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BEWERTUNGSKREIS_MONAT primary key (MANDANT_ID, BEWERTUNGSKREIS_ID, ART_ID, GJMO)
)COMMENT='TP2_AIS - Diese Tabelle enthält historisierte und korrigierte Daten auf monatlicher Ebene aus der SAP Tabelle mbew - MULTISET'
;