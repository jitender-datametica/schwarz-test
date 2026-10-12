create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_KREISTYP_GRUPPE_WUP_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	KREISTYP_GRUPPE_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Region / Gruppierung Kreistypen',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_KREISTYP_GRUPPE_WUP_ZU primary key (MANDANT_ID, WUP_ID, NB_ID, ART_ID)
)COMMENT='AIS - Zuordnungstabelle Artikel-Markt zu kreistyp_gruppe'
;