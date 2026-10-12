CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_INTERNAL_ORGANIZATION_STATUS_TYPE_1 
	(INT_ORG_STATUS_CD  COMMENT 'The code for the lifecycle status_1 of an internal organization.'
	,INT_ORG_STATUS_DESCR COMMENT 'A textual description for the lifecycle status_1 of an internal organization in group language, i.e. in German.'
	,INT_ORG_STATUS_DESCR_DE  COMMENT 'A textual description for the lifecycle status_1 of an internal organization in German.'
	,INT_ORG_STATUS_DESCR_EN  COMMENT 'A textual description for the lifecycle status_1 of an internal organization in English.'
	,DWH_CREATED_TMSP  COMMENT 'The point in time when this record was created in the data warehouse.'
	,DWH_UPDATED_TMSP  COMMENT 'The point in time when this record was created or last updated.'
	,DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
	,DWH_NODE_CD  COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.')
	AS 
SELECT 
INT_ORG_STATUS_CD
,INT_ORG_STATUS_DESCR
,INT_ORG_STATUS_DESCR_DE
,INT_ORG_STATUS_DESCR_EN
,DWH_CREATED_TMSP
,DWH_UPDATED_TMSP
,DWH_LOAD_ID
,DWH_NODE_CD

FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_STATUS_TYPE_1 ;
