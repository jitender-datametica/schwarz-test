CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_DATAAVAIL_STORE_QUOTA_1 AS 
SELECT 
    main.DAT_DAYEND
    ,main.YEAR
    ,main.MONTH
    ,main.MONTH_NAME
    ,main.MONTH_ID
    ,main.WEEK
    ,main.WEEK_NAME
    ,main.WEEK_ID
    ,main.CLIENT_ID
    ,main.COUNTRY_NAME_SHORT
    ,main.COUNTRY_NAME
    ,main.COUNTRY_FLAG
    ,main.WH_ID
    ,main.WH_DESC
    ,main.WH_TYPE 
    ,main.ORIG_STORE_NR
    ,main.STORE_DESC
    ,main.SYSTEM_KEY
    ,main.SYSTEM_DESC
    ,SUM(CASE WHEN main.missed_fg = 0 THEN 1 ELSE 0 END) AS received_fg
    ,SUM(CASE WHEN ut.missed_fg = 0 THEN 1 ELSE 0 END) AS received_fg_today
    ,COUNT(main.dat_dayend) AS expected_fg
    ,expected_fg - received_fg AS missed_fg
    ,expected_fg - received_fg_today AS missed_fg_today
    ,received_fg/expected_fg AS quota
    ,received_fg_today/expected_fg AS quota_today
FROM FE_MSTR_BCBI.V_DATAAVAIL_STORE_LOAD_STATUS_PRESENT_1 main
LEFT JOIN FE_MSTR_BCBI.V_DATAAVAIL_STORE_LOAD_STATUS_PRESENT_TODAY_1 ut 
    ON  main.CLIENT_ID  = ut.CLIENT_ID 
    AND main.WH_ID      = ut.WH_ID 
    AND main.SYSTEM_KEY = ut.SYSTEM_KEY
    AND main.ORIG_STORE_NR = ut.ORIG_STORE_NR
    AND main.DAT_DAYEND = ut.DAT_DAYEND 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
--order by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
;