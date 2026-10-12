CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_WH_LOAD_STATUS_PRESENT
AS 
SELECT
    main.CLIENT_ID
    ,main.COUNTRY_NAME_SHORT
    ,main.COUNTRY_NAME
    ,main.WH_ID
    ,main.WH_DESC 
    ,main.WH_TYPE
    ,main.SYSTEM_KEY
    ,main.SYSTEM_DESC
    ,main.DAT_DAYEND 
    ,main.WEEK
    ,main.WEEK_NAME
    ,main.WEEK_ID
    ,main.MONTH
    ,main.MONTH_NAME
    ,main.MONTH_ID
    ,main.YEAR
    ,main.BUS_YEAR
    ,main.COUNTRY_FLAG
    ,main.COUNTRY_NAME_FLAG
    ,MAX(hq_master.is_hq_ma_missing) AS is_hq_master_missing 
    ,MAX(main.IS_PREV_MISSING) AS is_prev_days_missing 
    ,COUNT(DISTINCT main.interface_key) AS expected_total
    ,COUNT(DISTINCT CASE WHEN main.is_optional=0 THEN main.interface_key ELSE NULL END) AS expected_mandatory_total
    ,COUNT(DISTINCT CASE WHEN main.is_optional=1 THEN main.interface_key ELSE NULL END) AS expected_optional_total
    ,CASE WHEN main.SYSTEM_KEY IN (3,5) THEN expected_mandatory_total 
          ELSE 1
     END AS expected_min
    ,SUM(main.is_missing) AS missing_total
    ,SUM(main.is_missing_mandatory) AS missing_mandatory_total
    ,SUM(main.is_missing_optional) AS missing_optional_total
    ,expected_total - missing_total AS received_total
    ,expected_mandatory_total - missing_mandatory_total AS received_mandatory_total
    ,expected_optional_total - missing_optional_total AS received_optional_total
	
    ,CASE WHEN main.SYSTEM_KEY = 3 AND (missing_mandatory_total >= 1 AND is_prev_days_missing = 0) THEN 1 --HQ Master
		WHEN main.SYSTEM_KEY = 3 AND (is_prev_days_missing = 1) THEN 2 --HQ Master --für LaLüLo
        WHEN main.SYSTEM_KEY = 4 AND (missing_mandatory_total >= 1) THEN 1 
		WHEN main.SYSTEM_KEY = 4 AND (is_hq_master_missing = 1 ) THEN 3 --HQ Move
		WHEN main.SYSTEM_KEY = 5 AND (missing_mandatory_total >= 1 ) THEN 1 --WH Master
		WHEN main.SYSTEM_KEY = 5 AND (is_hq_master_missing = 1 ) THEN 3 --WH Master
		WHEN main.SYSTEM_KEY = 5 AND (is_prev_days_missing = 1 ) THEN 2 --WH Master --für LaLüLo
		WHEN main.SYSTEM_KEY IN (6,16,10,11,8,9,14,18,20,21) AND received_total = 0 THEN 1
ELSE 0
END AS missed_fg
    ,CASE WHEN missed_fg = 1 THEN 'Fehlt'
          WHEN missed_fg = 2 THEN 'LaLüLo'
          WHEN missed_fg = 3 THEN 'HQ Master fehlt'
          ELSE 'OK'
      END AS missed_fg_desc
     ,CASE WHEN missing_mandatory_total > 0 AND received_total > 0 THEN 1 ELSE 0 END AS incomplete_fg
     ,MIN(ft.first_trans_date) first_trans_date
FROM FE_MSTR_BCBI.V_DATAAVAIL_WH_DETAIL main
LEFT OUTER JOIN ( SELECT client_id, dat_dayend, MAX(is_missing_mandatory) is_hq_ma_missing
            FROM FE_MSTR_BCBI.V_DATAAVAIL_WH_DETAIL 
            WHERE system_key = 3
            GROUP BY client_id, dat_dayend
           ) hq_master --check whether HQ_MASTER was delivered on that day 
    ON  hq_master.client_id  = main.client_id
    AND hq_master.dat_dayend = main.dat_dayend
LEFT OUTER JOIN FE_MSTR_BCBI.V_DATAAVAIL_WH_FIRST_TRANSFER ft
    ON  ft.CLIENT_ID  = main.CLIENT_ID  
    AND ft.WH_ID      = main.WH_ID      
    AND ft.SYSTEM_KEY = main.SYSTEM_KEY 
    AND ft.DAT_DAYEND = main.DAT_DAYEND 
    AND main.IS_MISSING_MANDATORY > 0
WHERE 1=1 AND main.SYSTEM_KEY NOT IN (2,13) --EJR,TXJ
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19;