--t_dim_real_estate_event_type_2
DELETE FROM core_dim.T_DIM_REAL_ESTATE_EVENT_TYPE_2;

INSERT into core_dim.T_DIM_REAL_ESTATE_EVENT_TYPE_2
(
	REAL_ESTATE_EVENT_TYPE_CD
	,REAL_ESTATE_EVENT_TYPE_DESCR
	,REAL_ESTATE_EVENT_TYPE_DESCR_DE
	,REAL_ESTATE_EVENT_TYPE_DESCR_EN
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_LOAD_ID
	,DWH_NODE_CD
)
with 
st_en as
(
    SELECT *
    FROM core_rel.T_REAL_ESTATE_STATUS_TYPE_2
    WHERE LANG_CD = 'EN'
        and REAL_ESTATE_STATUS_CATEG_CD = 'BS'
),
st_de as
(
    SELECT *, 
    FROM core_rel.T_REAL_ESTATE_STATUS_TYPE_2
    WHERE LANG_CD = 'DE'
        and REAL_ESTATE_STATUS_CATEG_CD = 'BS'
)
select 
    CASE
        -- turn status_2 "Under Contract" into event "Contract Signed"
        WHEN nvl(st_de.REAL_ESTATE_STATUS_CD, st_en.REAL_ESTATE_STATUS_CD) = 'UC' THEN 'CS'
        ELSE nvl(st_de.REAL_ESTATE_STATUS_CD, st_en.REAL_ESTATE_STATUS_CD) 
    END                                                                     as REAL_ESTATE_EVENT_TYPE_CD

    ,CASE
        -- turn status_2 "Under Contract" into event "Contract Signed"
        WHEN REAL_ESTATE_EVENT_TYPE_CD = 'CS' THEN 'Vertrag unterzeichnet'
        WHEN REAL_ESTATE_EVENT_TYPE_CD = 'CN' THEN 'Objekt abgesagt'
        ELSE nvl(st_de.REAL_ESTATE_STATUS_DESCR, st_en.REAL_ESTATE_STATUS_DESCR) 
    END                                                                     as REAL_ESTATE_EVENT_TYPE_DESCR

    ,CASE
        -- turn status_2 "Under Contract" into event "Contract Signed"
        WHEN REAL_ESTATE_EVENT_TYPE_CD = 'CS' THEN 'Vertrag unterzeichnet'
        WHEN REAL_ESTATE_EVENT_TYPE_CD = 'CN' THEN 'Objekt abgesagt'
        ELSE st_de.REAL_ESTATE_STATUS_DESCR 
    END                                                                     as REAL_ESTATE_EVENT_TYPE_DESCR_DE

    ,CASE
        -- turn status_2 "Under Contract" into event "Contract Signed"
        WHEN REAL_ESTATE_EVENT_TYPE_CD = 'CS' THEN 'Contract signed'
        WHEN REAL_ESTATE_EVENT_TYPE_CD = 'CN' THEN 'Object cancelled'
        ELSE st_en.REAL_ESTATE_STATUS_DESCR
    END                                                                     as REAL_ESTATE_EVENT_TYPE_DESCR_EN

    ,current_timestamp
    ,current_timestamp
    ,-1
    ,'CORE_REL'
from st_en
    full outer join st_de on st_en.REAL_ESTATE_STATUS_CD = st_de.REAL_ESTATE_STATUS_CD 

UNION ALL

SELECT
	'@'            as REAL_ESTATE_EVENT_TYPE_CD
	,'Unbekannt'   as REAL_ESTATE_EVENT_TYPE_DESCR
	,'Unbekannt'   as REAL_ESTATE_EVENT_TYPE_DESCR_DE
	,'Unknown'     as REAL_ESTATE_EVENT_TYPE_DESCR_EN
    ,current_timestamp
    ,current_timestamp
    ,-1
    ,'CORE_REL'
FROM DUAL;
