create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache ',
	ART_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung aus SAP Retail.',
	INT_ART_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung aus ZSM, Diese können von SAP Retail Bezeichnungen abweichen.(ZSM:Zentrale Stammdaten Management, das verteilt die Bezeichnungen an SAP Retail, das diese überschreiben kann.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_SPR_ZU primary key (MANDANT_ID, ART_ID, SPR_ID)
)COMMENT='TP2_AIS - Sprachabhaengige Bezeichnungen der Artikel_1'
;
