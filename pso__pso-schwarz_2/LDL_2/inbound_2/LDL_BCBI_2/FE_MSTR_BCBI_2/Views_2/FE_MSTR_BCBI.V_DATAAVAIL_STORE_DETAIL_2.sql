CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_STORE_DETAIL_2 AS
SELECT
    ex.CLIENT_ID
    ,country.COUNTRY_ISO AS COUNTRY_NAME_SHORT
    ,country.COUNTRY_NAME AS COUNTRY_NAME
    ,ex.WH_ID
    ,ex.WH_DESC
    ,ex.WH_TYPE 
    ,ex.ORIG_STORE_NR 
    ,ex.STORE_DESC
    ,ex.system_key
    ,ex.system_desc
    ,ex.interface_key
    ,ex.interface_desc
    ,ex.DAT_OPEN AS DAT_DAYEND 
    ,calweek.WEEK_OF_YEAR AS WEEK
    ,calweek.cy_week_short_name AS WEEK_NAME
    ,calweek.cy_week AS WEEK_ID
    ,calday.month_of_year AS MONTH
    ,calday.month_of_year_name AS MONTH_NAME
    ,calday.cy_month AS MONTH_ID
    ,calday.cy AS YEAR
    ,CONCAT(
        '<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_'
        ,country.COUNTRY_NAME
        ,'.png" style="width:25px"/>'
    ) AS COUNTRY_FLAG
    ,CONCAT(
        '<span>'
        ,'<img src="../images/_custom/lidl/BCBI/Laenderflaggen/Flaggen_RGB_'
        ,country.COUNTRY_NAME
        ,'.png" style="width:25px;margin-right:15px;padding-top:5px"/>'
        ,country.COUNTRY_NAME
        ,'</span>'
    ) AS country_name_flag
    ,IS_MANDATORY
    ,lsp.MAIL_ROWS 
    ,NVL(lsp.trans_fg,0) AS IS_TRANSFORMED
    ,CASE WHEN ex.is_mandatory=1 AND lsp.mail_rows IS NULL THEN 1 ELSE 0 END AS is_missing_mandatory 
    ,CASE WHEN ex.is_mandatory=0 AND lsp.mail_rows IS NULL THEN 1 ELSE 0 END AS is_missing_optional
FROM FE_MSTR_BCBI.V_DATAAVAIL_STORE_EXPECTED_LIST_2 AS ex
LEFT JOIN ( SELECT lsp.CLIENT_ID, wh.WH_ID, lsp.ORIG_STORE_NR , lsp.STORE_DESC 
            , lsp.SYSTEM_KEY, lsp.INTERFACE_KEY, lsp.DAT_DAYEND, lsp.MAIL_ROWS, lsp.TRANS_FG
            FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_2 lsp 
            INNER JOIN (SELECT DISTINCT SRC_WH_ID AS WH_ID, LOC_SID_WH, DWH_VALID_FROM, DWH_VALID_TO FROM FE_MSTR_BCBI.T_WAREHOUSE_2) wh --to get SRC_WH_ID (as WH_ID)
                ON lsp.wh_loc_sid = wh.loc_sid_wh
                AND lsp.dat_dayend BETWEEN wh.DWH_VALID_FROM AND wh.DWH_VALID_TO 
            WHERE lsp.system_key IN (2, 13)
            AND lsp.DAT_DAYEND = TO_DATE(lsp.TIMESTAMP_LOAD_BCBI)-1 --Since this table contailns data for the last 30 days(DAT_DAYEND) for each day(TIMESTAMP_LOAD_BCBI), the most recent DAT_DAYEND was taken.
          ) AS lsp --to get MAIL_ROWS at 6 am the next day
    ON  lsp.CLIENT_ID     = ex.CLIENT_ID 
    AND lsp.WH_ID         = ex.WH_ID 
    AND lsp.ORIG_STORE_NR = ex.ORIG_STORE_NR 
    AND lsp.SYSTEM_KEY    = ex.SYSTEM_KEY 
    AND lsp.INTERFACE_KEY = ex.INTERFACE_KEY
    AND lsp.DAT_DAYEND    = ex.DAT_OPEN
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_DAY_2 AS calday ON ex.DAT_OPEN = calday.cal_dt
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_WEEK_2 AS calweek ON calday.cy_week = calweek.cy_week
LEFT JOIN FE_MSTR_BCBI.T_COUNTRY_2 AS country_2 ON ex.client_id = country.client_id;