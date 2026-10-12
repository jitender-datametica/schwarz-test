CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TIME_STORE_EXPECTED_LIST_1 AS
SELECT
    m.client_id
    ,c.country_iso
    ,wh.src_wh_id AS wh_id
    ,m.loc_sid_wh
    ,lsp_1.wh_desc
    ,wha.WH_TYPE
    ,m.loc_sid_store
    ,lsp_1.orig_store_nr
    ,lsp_1.store_desc
    ,typ.source_system
    ,m.dat_open
FROM
    FE_MSTR_BCBI.t_sys_md_storelist_1 m
    INNER JOIN (SELECT DISTINCT SRC_WH_ID, loc_sid_wh FROM FE_MSTR_BCBI.T_WAREHOUSE_1) wh ON m.loc_sid_wh = wh.loc_sid_wh
    INNER JOIN FE_MSTR_BCBI.T_COUNTRY_1 c ON m.client_id = c.client_id
    INNER JOIN (SELECT DISTINCT CLIENT_ID,WH_ID,WH_TYPE,WH_ACTIVE_FG FROM FE_MSTR_BCBI.T_DATAAVAIL_WH_EXPECTED_LIST_1 WHERE DAT_REC_END = '9999-12-31') wha 
        ON  wha.CLIENT_ID = m.CLIENT_ID 
        AND wha.WH_ID     = wh.SRC_WH_ID 
        AND wha.WH_ACTIVE_FG = 1
        --AND m.dat_open BETWEEN wha.DAT_REC_START AND wha.DAT_REC_END
    INNER JOIN (SELECT DISTINCT CLIENT_ID, ST_LOC_SID,orig_store_nr,wh_loc_sid, wh_desc,store_desc--,dat_dayend 
               FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_1 
               WHERE st_loc_sid != 0 
               AND dat_dayend > CURRENT_DATE-90 
              --AND TO_DATE(TIMESTAMP_LOAD_BCBI) = dat_dayend+1
               QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, ST_LOC_SID,orig_store_nr,wh_loc_sid ORDER BY dat_dayend DESC) = 1
               ) lsp_1  
               ON  lsp_1.CLIENT_ID  = m.CLIENT_ID 
               AND lsp_1.ST_LOC_SID = m.LOC_SID_STORE 
               AND lsp_1.WH_LOC_SID = m.loc_sid_wh 
               --AND lsp.DAT_DAYEND = m.DAT_OPEN 
	LEFT JOIN 

(SELECT DISTINCT gps.client_id,gps.loc_sid,'GPS' AS source_system FROM 
FE_MSTR_BCBI.T_TIME_TRACKING_RECORD_1 AS gps
 JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST_1 WHERE ACTIVE_TO_DT = '9999-12-30' ) AS TYPE
 ON gps.TIME_TYPE_SID = TYPE.TIME_TYPE_SID
 WHERE TYPE.PERFORMANCE_RELEVANT_FG = 1
 
 UNION
 
SELECT DISTINCT ptm.client_id,ptm.loc_sid ,'PTM' AS source_system FROM 
FE_MSTR_BCBI.T_TIME_TRACKING_PERIOD_1 AS ptm
  JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST_1 WHERE ACTIVE_TO_DT = '9999-12-30' ) AS TYPE
 ON ptm.TIME_TYPE_SID = TYPE.TIME_TYPE_SID
 WHERE TYPE.PERFORMANCE_RELEVANT_FG = 1

UNION

 SELECT DISTINCT gpsmiss.client_id, gpsmiss.loc_sid,'GPS' AS source_system FROM 
 FE_MSTR_BCBI.T_TIME_TRACKING_DAY_1 AS gpsmiss
  JOIN (SELECT * FROM FE_MSTR_BCBI.T_TIME_TYPE_HIST_1 WHERE ACTIVE_TO_DT = '9999-12-30' ) AS TYPE
 ON gpsmiss.TIME_TYPE_SID = TYPE.TIME_TYPE_SID
 WHERE TYPE.PERFORMANCE_RELEVANT_FG = 1) AS typ 
 
ON m.client_id = typ.client_id
AND  m.loc_sid_store = typ.loc_sid
  
WHERE
   m.dat_open BETWEEN CURRENT_DATE - 15 AND CURRENT_DATE - 1;