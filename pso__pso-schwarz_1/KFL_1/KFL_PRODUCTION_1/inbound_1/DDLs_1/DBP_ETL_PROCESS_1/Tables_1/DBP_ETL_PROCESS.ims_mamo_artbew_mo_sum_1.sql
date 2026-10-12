CREATE OR REPLACE TABLE IMS_MAMO_ARTBEW_MO_SUM_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Monat_1 eines Kalenderjahres, Format JJJJMM',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	MENGE NUMBER(18,3) NOT NULL COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
	UMSATZ_NETTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	EK_MEP NUMBER(18,4) NOT NULL COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='WWC - Redundanz zu artbew_mo_sum_1 aufgrund Performance'
;