create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.T_AGG_WH_DAY_PCH_1 cluster by (CLIENT_ID, DWH_CAL_DT)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the Lidl country.',
	LOC_SID_WH NUMBER(38,0) COMMENT 'surrogate Key for Warehouse.',
	WH_ID NUMBER(38,0) NOT NULL COMMENT 'Warehouse.',
	ASPECT_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)',
	PCWO_REASON_ID NUMBER(38,0) COMMENT 'Unique ID for PV >100 local reasons.',
	SFOTYPE_ID NUMBER(38,0) COMMENT 'document type.',
	CURRENCY_ISO_CD VARCHAR(3) COMMENT 'Currency .',
	PCH_BNL_SWITCH_FG NUMBER(38,0) COMMENT '1=calculated with new method.',
	DWH_CAL_DT DATE NOT NULL COMMENT 'Logical Date of Row.',
	VAL_PRICE_CHANGE NUMBER(19,5) COMMENT 'Calculated Aggregation.'
)COMMENT='Combined Solution for Report JIRA-LEAD03-6673.'
;
