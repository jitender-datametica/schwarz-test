create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_DISPATCH_GROUP_2(
	DISPATCH_GRP_NR COMMENT 'The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization.',
	DISPATCH_GRP_DESCR COMMENT 'A textual description for the dispatch group. (Description in group language, i.e. in German)',
	DISPATCH_GRP_DESCR_DE COMMENT 'A textual description for the dispatch group. (Description in German)',
	DISPATCH_GRP_DESCR_EN COMMENT 'A textual description for the dispatch group. (Description in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A dispatch group defines a group of products which are handled together in the logistics process.'
 as SELECT
     main.DISPATCH_GRP_NR
	,main.COUNTRY_ORG_SID
	,main.DISPATCH_GRP_DESCR   
	,main.DISPATCH_GRP_DESCR_DE   
	,main.DISPATCH_GRP_DESCR_EN    
	,main.DWH_CREATED_TMSP    
	,main.DWH_UPDATED_TMSP    
	,main.DWH_LOAD_ID
	,main.DWH_NODE_CD
    FROM CORE_DIM.T_DIM_DISPATCH_GROUP_2 main;