create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_KREISTYP_GRUPPE_WUP_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	KREISTYP_GRUPPE_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Region_2 / Gruppierung Kreistypen',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_KREISTYP_GRUPPE_WUP_ZU primary key (MANDANT_ID, WUP_ID, NB_ID, ART_ID)
)COMMENT='AIS - Zuordnungstabelle Artikel_2-Markt zu kreistyp_gruppe'
;