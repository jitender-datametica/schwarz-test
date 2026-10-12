create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_BACKPROGRAMM_ZU_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BACK_PROGRAMM_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Backprogramms aus bake_program. Numerischer Wert',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BACKPROGRAMM_ZU primary key (ART_ID, MANDANT_ID, BACK_PROGRAMM_ID)
)COMMENT='VIS Backshop - Diese Tabelle ordnet den Artikeln die Backprogramme zu. Quelle ist die SAP-Klassenbibliothek'
;
