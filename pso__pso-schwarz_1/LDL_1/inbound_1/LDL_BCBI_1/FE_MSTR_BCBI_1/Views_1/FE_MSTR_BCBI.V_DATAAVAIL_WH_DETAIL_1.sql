CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_WH_DETAIL_1
AS
SELECT
    ex.CLIENT_ID
    ,country.COUNTRY_ISO AS COUNTRY_NAME_SHORT
    ,country.COUNTRY_NAME AS COUNTRY_NAME
    ,ex.WH_ID
    ,ex.WH_DESC
    ,ex.WH_TYPE 
    ,ex.SYSTEM_KEY
    ,ex.SYSTEM_DESC
    ,ex.INTERFACE_KEY
    ,ex.INTERFACE_DESC
    ,ex.IS_OPTIONAL
    ,dates.cal_dt AS DAT_DAYEND 
    ,calweek.WEEK_OF_YEAR AS WEEK
    ,calweek.cy_week_short_name AS WEEK_NAME
    ,calweek.cy_week AS WEEK_ID
    ,dates.month_of_year AS MONTH
    ,dates.month_of_year_name AS MONTH_NAME
    ,dates.cy_month AS MONTH_ID
    ,dates.cy AS YEAR
    ,dates.BUS_YEAR AS BUS_YEAR
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
    ) AS COUNTRY_NAME_FLAG
    ,lsp.MAIL_ROWS 
    ,NVL(lsp.trans_fg,0) AS is_transformed
            ,CASE WHEN is_optional=0 AND ex.system_key IN (6,16,10,11,8,9,14,20,21,18)
        AND dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --mark the row as is_missing, only when the WH was active
        AND lsp.mail_rows IS NULL --mail_rows=0 means the file is delivered
        THEN 1
        WHEN is_optional=0 AND ex.system_key = 5 AND ex.INTERFACE_KEY = 203 AND mail_rows >= 0 --Exeption
        AND dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --mark the row as is_missing, only when the WH was active
        THEN 0
        WHEN is_optional=0 AND ex.system_key IN (3,4,5) --3-HQ Master, 5-WH Master, 4 - HQ MOVE
        AND dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --mark the row as is_missing, only when the WH was active
        AND COALESCE(lsp.mail_rows,0) = 0 --both mail_rows is null and mail_rows=0 mean_1 the file is "NOT" delivered
        THEN 1
        ELSE 0
        END AS is_missing_mandatory --Possibility-1:there is no maching record with T_WAWI_SYS_LOAD_STATUS_PRESENT_1 && Possibility-2:mached but the value is NULL
        ,CASE WHEN is_optional=1 AND ex.system_key IN (6,16,10,11,8,9,14,20,21,18)
        AND dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --mark the row as is_missing, only when the WH was active
        AND lsp.mail_rows IS NULL --mail_rows=0 means the file is delivered
        THEN 1
        WHEN is_optional=1 AND ex.system_key = 5 AND ex.INTERFACE_KEY = 203 AND mail_rows >= 0 --Exeption
        AND dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --mark the row as is_missing, only when the WH was active
        THEN 0
        WHEN is_optional=1 AND ex.system_key IN (3,4,5) --3-HQ Master, 5-WH Master, 4 - HQ MOVE
        AND dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END --mark the row as is_missing, only when the WH was active
        AND COALESCE(lsp.mail_rows,0) = 0 --both mail_rows is null and mail_rows=0 mean_1 the file is "NOT" delivered
        THEN 1
        ELSE 0
        END AS is_missing_optional
    ,is_missing_mandatory + is_missing_optional AS is_missing
    ,COALESCE(lsp_prev.is_missing,0) AS is_prev_missing --since IS_PREV_MISSING is just used for LaLüLo, only the rows with is_optional=0 are considered
FROM FE_MSTR_BCBI.T_DATAAVAIL_WH_EXPECTED_LIST_1 AS ex
INNER JOIN (SELECT cal_dt,month_of_year,month_of_year_name,cy_month,cy,bus_year,cy_week FROM FE_MSTR_BCBI.T_DIM_CAL_DAY_1 --since wh_expected_list doesn't contain dat_dayend, each record in wh_expected_list is duplicated by each calendarday respectivly
                WHERE cal_dt BETWEEN TO_DATE('20231111','yyyymmdd') AND CURRENT_DATE-1 --min(TIMESTAMP_LOAD_BCBI) is '2022-04-24' in T_WAWI_SYS_LOAD_STATUS_PRESENT_1
           ) dates
           ON dates.cal_dt BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END
LEFT JOIN ( SELECT lsp.CLIENT_ID, wh.WH_ID, lsp.SYSTEM_KEY, lsp.INTERFACE_KEY, lsp.DAT_DAYEND, lsp.MAIL_ROWS, lsp.trans_fg, lsp.TIMESTAMP_LOAD_BCBI
            FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_1 lsp 
            INNER JOIN (SELECT DISTINCT SRC_WH_ID AS WH_ID, LOC_SID_WH, DWH_VALID_FROM, DWH_VALID_TO FROM FE_MSTR_BCBI.T_WAREHOUSE_1) wh --to get SRC_WH_ID (as WH_ID)
                ON lsp.wh_loc_sid = wh.loc_sid_wh
                AND lsp.dat_dayend BETWEEN wh.DWH_VALID_FROM AND wh.DWH_VALID_TO 
            WHERE lsp.system_key NOT IN (2, 13) --exclude 2-EJR and 13-TXJ
            AND lsp.DAT_DAYEND = TO_DATE(lsp.TIMESTAMP_LOAD_BCBI)-1 --Since this table contains data for the last 30 days(DAT_DAYEND) for each day(TIMESTAMP_LOAD_BCBI), the most recent DAT_DAYEND was taken.
          ) AS lsp --to get MAIL_ROWS at 6 am the next day
    ON  lsp.CLIENT_ID     = ex.CLIENT_ID 
    AND lsp.WH_ID         = ex.WH_ID 
    AND lsp.SYSTEM_KEY    = ex.SYSTEM_KEY 
    AND lsp.INTERFACE_KEY = ex.INTERFACE_KEY
    AND lsp.DAT_DAYEND    = dates.CAL_DT
LEFT JOIN ( SELECT CLIENT_ID,WH_ID,SYSTEM_KEY,INTERFACE_KEY,TIMESTAMP_LOAD_BCBI
                   , MAX(DAT_DAYEND)+1 AS DAT_DAYEND --since the all DAT_DAYENDs are smaller then current DAT_DAYEND we add 1 to max, so the result can be joined with main SQL
                   , MAX(is_missing) is_missing --MAX is used, since it doesn't matter how many days are missed, so we use this column as a flag
            FROM (
                SELECT lsp.CLIENT_ID,wh.WH_ID,lsp.SYSTEM_KEY,lsp.INTERFACE_KEY,lsp.DAT_DAYEND,lsp.TIMESTAMP_LOAD_BCBI
                , MAX(CASE WHEN is_optional=0 AND ex.system_key = 5 AND ex.INTERFACE_KEY = 203 AND mail_rows >= 0 --This case when is similar with the one in outer SQL 
                            AND lsp.DAT_DAYEND BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END 
                            THEN 0 --Exeption
                           WHEN is_optional=0 AND ex.system_key IN (2,13,4,6,16,10,11,8,9,14,20,21,18)
                               AND lsp.DAT_DAYEND BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END 
                               AND lsp.mail_rows IS NULL
                               THEN 1
                           WHEN is_optional=0 AND ex.system_key IN (3,5)
                               AND lsp.DAT_DAYEND BETWEEN ex.DAT_REC_START AND ex.DAT_REC_END 
                               AND COALESCE(lsp.mail_rows,0) = 0 THEN 1
                           ELSE 0
                      END) AS is_missing --since IS_PREV_MISSING is just used for LaLüLo, only the rows with is_optional=0 are considered
                FROM FE_MSTR_BCBI.T_WAWI_SYS_LOAD_STATUS_PRESENT_1 lsp
                INNER JOIN (SELECT DISTINCT SRC_WH_ID AS WH_ID, LOC_SID_WH, DWH_VALID_FROM, DWH_VALID_TO FROM FE_MSTR_BCBI.T_WAREHOUSE_1) wh --to get SRC_WH_ID (as WH_ID)
                    ON lsp.wh_loc_sid = wh.loc_sid_wh
                    AND lsp.dat_dayend BETWEEN wh.DWH_VALID_FROM AND wh.DWH_VALID_TO 
                INNER JOIN FE_MSTR_BCBI.T_DATAAVAIL_WH_EXPECTED_LIST_1 AS ex --to look just when WH was active (see calculation of is_missing)
                    ON  lsp.CLIENT_ID     = ex.CLIENT_ID 
                    AND wh.WH_ID          = ex.WH_ID  
                    AND lsp.SYSTEM_KEY    = ex.SYSTEM_KEY 
                    AND lsp.INTERFACE_KEY = ex.INTERFACE_KEY
                WHERE lsp.system_key NOT IN (2, 13)
                AND lsp.DAT_DAYEND < TO_DATE(lsp.TIMESTAMP_LOAD_BCBI)-1 --Since this table contains data for the last 30 days(DAT_DAYEND) for each day(TIMESTAMP_LOAD_BCBI), the previous DAT_DAYEND was taken.
                GROUP BY lsp.CLIENT_ID,wh.WH_ID,lsp.SYSTEM_KEY,lsp.INTERFACE_KEY,lsp.DAT_DAYEND,lsp.TIMESTAMP_LOAD_BCBI
            )
            GROUP BY CLIENT_ID,WH_ID,SYSTEM_KEY,INTERFACE_KEY,TIMESTAMP_LOAD_BCBI
          ) AS lsp_prev --to control whether any file is missing in last 30 days
    ON  lsp_prev.CLIENT_ID     = lsp.CLIENT_ID 
    AND lsp_prev.WH_ID         = lsp.WH_ID 
    AND lsp_prev.SYSTEM_KEY    = lsp.SYSTEM_KEY 
    AND lsp_prev.INTERFACE_KEY = lsp.INTERFACE_KEY
    AND lsp_prev.DAT_DAYEND    = lsp.DAT_DAYEND
    AND lsp_prev.TIMESTAMP_LOAD_BCBI = lsp.TIMESTAMP_LOAD_BCBI
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_WEEK_1 AS calweek ON dates.cy_week = calweek.cy_week
LEFT JOIN FE_MSTR_BCBI.T_COUNTRY_1 AS country_1 ON ex.client_id = country.client_id;