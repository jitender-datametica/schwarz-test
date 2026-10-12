create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_TS_AAD_THRESHOLD_WORKFLOW_1(
	MANDANT_ID,
	REGION_ID,
	SCENARIO_ID,
	SCENARIO_METRIC_ID,
	THRESHOLD_REQUEST_ID,
	SCENARIO_METRIC_THRESHOLD_INIT_VAL,
	SCENARIO_METRIC_USER_VAL,
	CREATOR_USER_ID,
	CREATION_REASON_COMMENT_TXT,
	REQUEST_STATUS_TYPE_ID,
	APPROVER_COMMENT_TXT,
	EXPIRATION_TMSP,
	DWH_CREATED_TMSP,
	GENEHMIGT_FLAG,
	THRESHOLD_VERLAUF,
	OFFENER_ANTRAG_FLAG
) as 
-- 30.06.2023 staeblern initale Erstellung 
WITH T_THRESHOLD_Verlauf AS (
    SELECT THRESHOLD_REQUEST_ID
    ,DWH_CREATED_TMSP
    , RANK() OVER (PARTITION BY THRESHOLD_REQUEST_ID ORDER BY DWH_CREATED_TMSP DESC) AS Threshold_Verlauf
    FROM DBP_MSI_DATA.ts_aad_threshold_workflow_1 
)

SELECT
    v01.mandant_id
    ,v01.region_id
    ,v01.scenario_id
    ,v01.scenario_metric_id
    ,v01.threshold_request_id
    ,v01.scenario_metric_threshold_init_val
    ,v01.scenario_metric_user_val
    ,v01.creator_user_id
    ,v01.creation_reason_comment_txt
    ,v01.request_status_type_id
    ,v01.approver_comment_txt
    ,v01.expiration_tmsp
    ,v01.dwh_created_tmsp
    , CASE v01.request_status_type_id 
        -- Genehmigt
        WHEN  6 THEN 1 
        -- abgelehnt 
        WHEN 7 THEN 0
        -- SONST 
        ELSE NULL 
        END 
    AS genehmigt_flag
    , Threshold_Verlauf
    , CASE WHEN v01.request_status_type_id = 5 AND Threshold_Verlauf = 1 THEN 1 ELSE 0 END AS offener_Antrag_flag
FROM DBP_MSI_DATA.ts_aad_threshold_workflow_1 v01
INNER JOIN T_THRESHOLD_Verlauf v02
ON v01.THRESHOLD_REQUEST_ID = v02.THRESHOLD_REQUEST_ID
AND v01.dwh_created_tmsp = v02.dwh_created_tmsp
;