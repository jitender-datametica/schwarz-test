CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_STORE_LOAD_STATUS_PRESENT_TODAY_1 AS 
SELECT
    main.CLIENT_ID
    ,main.COUNTRY_NAME_SHORT
    ,main.COUNTRY_NAME
    ,main.WH_ID
    ,main.WH_DESC 
    ,main.WH_TYPE
    ,main.ORIG_STORE_NR 
    ,main.STORE_DESC 
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
    ,main.COUNTRY_FLAG
    ,main.COUNTRY_NAME_FLAG

    ,COUNT(DISTINCT main.interface_key) AS expected_total
    ,SUM(main.is_missing_mandatory) AS missing_mandatory_total
    ,SUM(main.is_missing_optional) AS missing_optional_total
    ,expected_total - (missing_mandatory_total+missing_optional_total) AS received_total      
    ,CASE WHEN main.SYSTEM_KEY = 2 AND missing_mandatory_total >= 1 THEN 1 --EJR
          WHEN main.SYSTEM_KEY = 13 AND missing_mandatory_total >= 1 THEN 1 --TXJ
          ELSE 0
      END AS missed_fg
      ,CASE WHEN missed_fg = 0 THEN 'OK'
           ELSE 'Fehlt'
      END AS missed_fg_desc
     ,CASE WHEN missing_mandatory_total > 0 AND received_total > 0 THEN 1 ELSE 0 END AS incomplete_fg
     ,MIN(ft.first_trans_date) AS first_trans_date
FROM FE_MSTR_BCBI.V_DATAAVAIL_STORE_DETAIL_TODAY_1 main
LEFT OUTER JOIN FE_MSTR_BCBI.V_DATAAVAIL_STORE_FIRST_TRANSFER_1 ft
    ON  ft.CLIENT_ID  = main.CLIENT_ID  
    AND ft.WH_ID      = main.WH_ID  
    AND ft.ORIG_STORE_NR = main.ORIG_STORE_NR
    AND ft.SYSTEM_KEY = main.SYSTEM_KEY 
    AND ft.DAT_DAYEND = main.DAT_DAYEND 
    AND main.IS_MISSING_MANDATORY > 0
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
--ORDER BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
;