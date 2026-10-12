create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_BACK_AUFBEREITUNG_ZU (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BACK_AUFBEREITUNG_ID NUMBER(38,0) NOT NULL COMMENT 'eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BACK_AUFBEREITUNG_ZU primary key (ART_ID, MANDANT_ID, BACK_AUFBEREITUNG_ID)
)COMMENT='VIS Backshop - Zuordnung von Aufbereitungsanweisungen  zu Artikeln'
;
