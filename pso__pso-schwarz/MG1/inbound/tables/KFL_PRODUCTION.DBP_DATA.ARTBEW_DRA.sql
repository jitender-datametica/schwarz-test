create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTBEW_DRA (
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	DAT DATE NOT NULL COMMENT 'Tagesdatum in der Form JJJJ-MM-TT',
	AKTION_ID VARCHAR(10) NOT NULL COMMENT 'Eindeutige Kennung einer Aktion. Kommt aus der Kassenschnittstelle',
	PROMO_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)',
	EAN_KASSE NUMBER(26,0) NOT NULL COMMENT 'von den Kassensystemen gelieferte EAN',
	MENGE NUMBER(18,3) NOT NULL COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
	WRG VARCHAR(3) NOT NULL COMMENT 'Währung, in der der Umsatz erzielt wurde',
	UMSATZ_NETTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	UMSATZ_MWST_BETRAG NUMBER(18,4) NOT NULL COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTBEW_DRA primary key (WUP_ID, MANDANT_ID, BEWART_ID, GP_ID, NB_ID, ART_ID, DAT, AKTION_ID, PROMO_FG, EAN_KASSE)
)COMMENT='TP2_AIS - Hier sind die Umsätze von ca. 10 Märkten zu \"Deutschland rundet auf\" hinterlegt'
;