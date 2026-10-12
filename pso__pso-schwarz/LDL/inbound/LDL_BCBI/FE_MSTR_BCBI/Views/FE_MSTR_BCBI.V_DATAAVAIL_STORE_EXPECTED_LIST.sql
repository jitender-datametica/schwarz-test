CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_STORE_EXPECTED_LIST AS 
SELECT
    m.client_id
    ,c.country_iso
    ,wh.src_wh_id AS wh_id
    ,lsp_1.wh_desc
    ,wha.WH_TYPE
    ,lsp_1.orig_store_nr
    ,lsp_1.store_desc
    ,lsp_2.system_key
    ,lsp_2.system_desc
    ,lsp_2.interface_key
    ,lsp_2.interface_desc
    ,CASE WHEN interface_key IN (2,3,510,515) THEN 1 ELSE 0 END AS is_mandatory
    ,m.dat_open
FROM
    FE_MSTR_BCBI.t_sys_md_storelist m
    INNER JOIN (SELECT DISTINCT SRC_WH_ID, loc_sid_wh FROM FE_MSTR_BCBI.T_WAREHOUSE) wh ON m.loc_sid_wh = wh.loc_sid_wh
    INNER JOIN FE_MSTR_BCBI.T_COUNTRY c ON m.client_id = c.client_id
    INNER JOIN (SELECT DISTINCT CLIENT_ID,WH_ID,WH_TYPE,WH_ACTIVE_FG,DAT_REC_START,DAT_REC_END FROM FE_MSTR_BCBI.T_DATAAVAIL_WH_EXPECTED_LIST) wha 
        ON  wha.CLIENT_ID = m.CLIENT_ID 
        AND wha.WH_ID     = wh.SRC_WH_ID 
        AND wha.WH_ACTIVE_FG = 1
        AND m.dat_open BETWEEN wha.DAT_REC_START AND wha.DAT_REC_END
    INNER JOIN (SELECT DISTINCT CLIENT_ID, ST_LOC_SID,orig_store_nr,wh_loc_sid, wh_desc,store_desc--,dat_dayend 
               FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT 
               WHERE st_loc_sid != 0 
               AND mail_rows IS NOT NULL 
               AND dat_dayend > CURRENT_DATE-90 
               AND TO_DATE(TIMESTAMP_LOAD_BCBI) = dat_dayend+1
               QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, ST_LOC_SID,orig_store_nr,wh_loc_sid ORDER BY dat_dayend DESC) = 1
               ) lsp_1  
               ON  lsp_1.CLIENT_ID  = m.CLIENT_ID 
               AND lsp_1.ST_LOC_SID = m.LOC_SID_STORE 
               AND lsp_1.WH_LOC_SID = m.loc_sid_wh 
               --AND lsp.DAT_DAYEND = m.DAT_OPEN 
   INNER JOIN (SELECT DISTINCT CLIENT_ID, ST_LOC_SID,wh_loc_sid, system_key,system_desc,interface_key,interface_desc
               FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT 
               WHERE st_loc_sid != 0 
               AND mail_rows IS NOT NULL 
               AND dat_dayend > CURRENT_DATE-90 
               AND TO_DATE(TIMESTAMP_LOAD_BCBI) = dat_dayend+1
               ) lsp_2  
               ON  lsp_2.CLIENT_ID  = m.CLIENT_ID 
               AND lsp_2.ST_LOC_SID = m.LOC_SID_STORE 
               AND lsp_2.WH_LOC_SID = m.loc_sid_wh  
WHERE
   m.dat_open BETWEEN CURRENT_DATE - 90 AND CURRENT_DATE - 1
;