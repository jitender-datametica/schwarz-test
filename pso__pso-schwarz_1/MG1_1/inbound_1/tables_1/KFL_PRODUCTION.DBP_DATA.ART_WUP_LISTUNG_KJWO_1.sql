create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_LISTUNG_KJWO_1 cluster by (
     MANDANT_ID,
     KJWO 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KJWO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
	KREISTYP_GRUPPE_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Region_1 / Gruppierung Kreistypen',
	LISTUNG_ID NUMBER(38,0) COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_1 eigentlich obsolet',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_LISTUNG_KJWO primary key (MANDANT_ID, ART_ID, WG_ID, WUP_ID, NB_ID, KJWO)
)COMMENT='AIS - Artikellistung pro Markt / Kalenderwoche'
;