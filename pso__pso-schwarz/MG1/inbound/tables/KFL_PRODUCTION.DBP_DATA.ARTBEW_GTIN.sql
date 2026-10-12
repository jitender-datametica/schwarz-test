create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTBEW_GTIN cluster by (
     MANDANT_ID,
     DAT 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Markt',
	DAT DATE NOT NULL COMMENT 'Datum, Format YYYY-MM-DD',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT '1001 AF, 1002 SA',
	AKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Aktionsnummer wie von den Kassen gemeldet (bei Kassensystem POSITION über Stammdaten angereichert)',
	PROMO_FG NUMBER(38,0) NOT NULL COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)',
	EAN_KASSE NUMBER(26,0) NOT NULL COMMENT 'von den Kassensystemen gelieferte EAN',
	NB_ID NUMBER(38,0) COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	HERST_ID NUMBER(38,0) COMMENT 'Hersteller fall abweichend zum Lieferanten',
	MWST_ID NUMBER(38,0) NOT NULL COMMENT 'Schlüssel des Mehrwertsteuersatzes',
	WRG VARCHAR(3) COLLATE 'en-ci' COMMENT 'Währung, in der der Umsatz erzielt wurde',
	MENGE NUMBER(18,3) COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
	UMSATZ_NETTO NUMBER(18,4) COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	DIFF_UMSATZ_NETTO_KONZ NUMBER(18,4) COMMENT 'von der Konzernwährung abweichender Umsatz netto',
	UMSATZ_MWST_BETRAG NUMBER(18,4) COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.',
	DIFF_UMSATZ_MWST_BETRAG_KONZ NUMBER(18,4) COMMENT 'von der Konzernwährung abweichender Mehrwertsteuerbetrag',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTBEW_GTIN primary key (MANDANT_ID, WUP_ID, DAT, ART_ID, GP_ID, BEWART_ID, AKTION_ID, PROMO_FG, EAN_KASSE)
)COMMENT='Aggregat aus Bons aller Länder (auch für POSITION statt WPUUMS). Benötigt für Marktforschungsinstitute, die Abverkäufe auf Ebene GTIN brauchen. Tabelle nicht mehr relevant wenn Umstellung auf KPOS ausgerollt.'
;