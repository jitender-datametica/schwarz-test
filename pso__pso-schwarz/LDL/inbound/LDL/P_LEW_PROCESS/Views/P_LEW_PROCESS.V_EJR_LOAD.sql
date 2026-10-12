CREATE OR REPLACE VIEW P_LEW_PROCESS.V_EJR_LOAD
AS
SELECT 
 client_id
,loc_sid
,aspect_id
,dwh_cal_dt
,store_open_fg
,core
,solace
,dayend_completion
,ladequote
,ladequote_solace
,dayend_completion_backup

FROM 
(
SELECT 
 lg.client_id
,lg.loc_sid
,org_store.aspect_id
,lg.dwh_cal_dt
,lg.store_open_fg
,lg.core
,lg.solace
,lg.dayend_completion
,lg.ladequote
,lg.ladequote_solace
,lg.dayend_completion_backup
FROM
(
SELECT 
 COALESCE(st.client_id,base.client_id) AS client_id
,COALESCE(st.loc_sid_store,base.loc_sid) AS loc_sid
,COALESCE(st.dat_open,base.dwh_cal_dt) AS dwh_cal_dt
,CASE WHEN st.dat_open IS NOT NULL THEN 1 ELSE 0 END AS store_open_fg
,base.core
,base.solace
,CASE WHEN base.core > base.dayend_completion THEN base.core ELSE base.dayend_completion END AS dayend_completion
,SUM(CASE 
        WHEN base.dayend_completion IS NULL AND base.solace IS NOT NULL THEN 0
        ELSE 
            COALESCE(base.core, 0) / 
            COALESCE(
                CASE 
                    WHEN base.core > base.dayend_completion THEN base.core
                    ELSE base.dayend_completion 
                END, base.core,1)
    END
) * 100 AS ladequote

,SUM(COALESCE(base.solace,0)/COALESCE(base.dayend_completion, base.core,base.solace)) * 100 AS ladequote_solace
,base.dayend_completion AS dayend_completion_backup
FROM 
(
SELECT 
    client_id
    ,loc_sid
    ,dwh_cal_dt
    ,SUM(core) AS core
    ,SUM(solace) AS solace
    ,SUM(dayend_completion) AS dayend_completion
FROM
    p_lew_process.t_ejr_load_log
WHERE  (receipt_transactiontype_id IN ('100','101','150','151','200','201','250','251','300','301','350','351') 
OR receipt_transactiontype_id IS NULL)
AND dwh_cal_dt >= DATEADD(MONTH, -13, DATE_TRUNC('month', CURRENT_DATE))
GROUP BY 1,2,3
) base
FULL OUTER JOIN 
(SELECT * FROM 
p_lew_bil.v_sys_md_storelist st
WHERE st.dat_open >= DATEADD(MONTH, -13, DATE_TRUNC('month', CURRENT_DATE))
) st
ON st.client_id = base.client_id
AND st.loc_sid_store = base.loc_sid
AND st.dat_open = base.dwh_cal_dt
GROUP BY 1,2,3,4,5,6,7,10) lg

LEFT JOIN p_lew_core.t_wawi_org_store_merge_act org_store
ON lg.client_id = org_store.client_id
AND lg.loc_sid = org_store.st_loc_sid
)
;