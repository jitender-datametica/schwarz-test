create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_NFMD.TS_NFMD_COMMENTS_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	AKTION_ID VARCHAR(10) NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	KJWO_WW NUMBER(38,0) COMMENT 'Calendar_1 year-week when the promotion campaign started. Format JJJJWW',
	USER_ID VARCHAR(255) COMMENT 'AD name of the user who created the record',
	COMMENT_TXT VARCHAR(255) COMMENT 'text of the comment',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'timestamp when the record was created',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_NFMD_COMMENTS primary key (MANDANT_ID, AKTION_ID, ART_ID)
)COMMENT='The comments on  the utilization decision are stored in this table (per combination of  Article  and  PromotionCampaign) . \n             The comments can be created both in the first step of the exploitation decision and in the second step of the Markdown decision.'
;
