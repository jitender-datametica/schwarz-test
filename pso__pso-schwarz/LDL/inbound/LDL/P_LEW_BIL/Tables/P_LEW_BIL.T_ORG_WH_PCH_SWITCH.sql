create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_BIL.T_ORG_WH_PCH_SWITCH (
	ASPECT_ID NUMBER(38,0),
	CLIENT_ID NUMBER(38,0),
	WH_ID NUMBER(38,0),
	PCH_BNL_SWITCH_FG NUMBER(38,0),
	SWITCH_DATE DATE,
	DWH_UPDATED TIMESTAMP_NTZ(6)
)COMMENT='$Revision: 16853 $ : Part of PV-BNL solution: contains switch dates from P_LEW_TMP.old  to new Wawi versions per wh, it is filled manually with statements with info from Wawi'
;
