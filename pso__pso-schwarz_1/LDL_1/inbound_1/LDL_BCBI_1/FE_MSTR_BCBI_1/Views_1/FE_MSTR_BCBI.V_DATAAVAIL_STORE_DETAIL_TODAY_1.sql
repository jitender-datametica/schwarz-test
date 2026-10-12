CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_STORE_DETAIL_TODAY_1 AS
SELECT
    ex.CLIENT_ID
    ,country.COUNTRY_ISO AS COUNTRY_NAME_SHORT
    ,country.COUNTRY_NAME AS COUNTRY_NAME
    ,ex.WH_ID
    ,ex.WH_DESC
    ,ex.WH_TYPE 
    ,ex.ORIG_STORE_NR 
    ,ex.STORE_DESC
    ,ex.SYSTEM_KEY
    ,ex.SYSTEM_DESC
    ,ex.INTERFACE_KEY
    ,ex.INTERFACE_DESC
    ,ex.DAT_OPEN AS DAT_DAYEND 
    ,calweek.WEEK_OF_YEAR AS WEEK
    ,calweek.CY_WEEK_SHORT_NAME AS WEEK_NAME
    ,calweek.CY_WEEK AS WEEK_ID
    ,calday.MONTH_OF_YEAR AS MONTH
    ,calday.MONTH_OF_YEAR_NAME AS MONTH_NAME
    ,calday.CY_MONTH AS MONTH_ID
    ,calday.CY AS YEAR
    ,CONCAT(
        '<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_'
        ,country.COUNTRY_NAME
        ,'.png" style="width:25px"/>'
    ) AS country_flag
    ,CONCAT(
        '<span>'
        ,'<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_'
        ,country.COUNTRY_NAME
        ,'.png" style="width:25px;margin-right:15px;padding-top:5px"/>'
        ,country.COUNTRY_NAME
        ,'</span>'
    ) AS country_name_flag
    ,is_mandatory
    ,lsp.mail_rows 
    ,NVL(lsp.trans_fg,0) AS IS_TRANSFORMED
    ,CASE WHEN ex.is_mandatory=1 AND lsp.mail_rows IS NULL THEN 1 ELSE 0 END AS is_missing_mandatory 
    ,CASE WHEN ex.is_mandatory=0 AND lsp.mail_rows IS NULL THEN 1 ELSE 0 END AS is_missing_optional
    --,coalesce(lsp_prev.is_missing,0) AS is_prev_missing --since IS_PREV_MISSING is just used for LaLüLo, only the rows with is_optional=0 are considered
FROM FE_MSTR_BCBI.V_DATAAVAIL_STORE_EXPECTED_LIST_1 AS ex
LEFT JOIN ( SELECT lsp.CLIENT_ID, wh.WH_ID, lsp.ORIG_STORE_NR , lsp.STORE_DESC 
            , lsp.SYSTEM_KEY, lsp.INTERFACE_KEY, lsp.DAT_DAYEND, lsp.MAIL_ROWS,lsp.trans_fg
            FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_1 lsp 
            INNER JOIN (SELECT DISTINCT SRC_WH_ID AS WH_ID, LOC_SID_WH, DWH_VALID_FROM, DWH_VALID_TO FROM FE_MSTR_BCBI.T_WAREHOUSE_1) wh --to get SRC_WH_ID (as WH_ID)
                ON lsp.wh_loc_sid = wh.loc_sid_wh
                AND lsp.dat_dayend BETWEEN wh.DWH_VALID_FROM AND wh.DWH_VALID_TO 
            WHERE lsp.system_key IN (2, 13)
            AND DATE(lsp.TIMESTAMP_LOAD_BCBI) = CURRENT_DATE
        --AND lsp.TIMESTAMP_LOAD_BCBI = (SELECT MAX(TIMESTAMP_LOAD_BCBI) FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_1 WHERE system_key NOT IN (2, 13)) --until_today
          ) AS lsp --to get MAIL_ROWS at 6 am the next day
    ON  lsp.CLIENT_ID     = ex.CLIENT_ID 
    AND lsp.WH_ID         = ex.WH_ID 
    AND lsp.ORIG_STORE_NR = ex.ORIG_STORE_NR 
    AND lsp.SYSTEM_KEY    = ex.SYSTEM_KEY 
    AND lsp.INTERFACE_KEY = ex.INTERFACE_KEY
    AND lsp.DAT_DAYEND    = ex.DAT_OPEN
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_DAY_1 AS calday ON ex.DAT_OPEN = calday.cal_dt
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_WEEK_1 AS calweek ON calday.cy_week = calweek.cy_week
LEFT JOIN FE_MSTR_BCBI.T_COUNTRY_1 AS country_1 ON ex.client_id = country.client_id
WHERE ex.DAT_OPEN > CURRENT_DATE-30;