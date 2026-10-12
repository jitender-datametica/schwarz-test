CREATE OR REPLACE TABLE IMS_MAMO_ARTBEW_MO_SUM (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	KJMO INTEGER NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID INTEGER NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	BEWART_ID INTEGER NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	MENGE NUMBER(29,3) NOT NULL COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
	UMSATZ_NETTO NUMBER(29,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	EK_MEP NUMBER(29,4) NOT NULL COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='WWC - Redundanz zu artbew_mo_sum aufgrund Performance'
;