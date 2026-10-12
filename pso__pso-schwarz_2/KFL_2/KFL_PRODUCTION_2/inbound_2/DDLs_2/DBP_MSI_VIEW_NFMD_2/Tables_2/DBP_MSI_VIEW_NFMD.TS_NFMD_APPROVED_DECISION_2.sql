create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	AKTION_ID VARCHAR(10) NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	KJWO_WW NUMBER(38,0) COMMENT 'Calendar_2 year-week when the promotion campaign started. Format JJJJWW',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'timestamp when the record was created',
	USER_ID VARCHAR(255) COMMENT 'AD name of the user who created the record',
	MARKDOWN_DECISION_ID NUMBER(38,0) COMMENT 'Utilization decision ID - maintained via the frontend',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_NFMD_APPROVED_DECISION primary key (MANDANT_ID, AKTION_ID, ART_ID)
)COMMENT='The release price reduction decision is set for each combination of Article and PromotionCampaign in this table - populated by Frontend'
;
