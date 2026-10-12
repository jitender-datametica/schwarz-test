--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 COALESCE(HAUPT_WUP_ID, WUP_ID) AS HAUPT_WUP_ID,
 NB_ID,
 WUP_ID
FROM KFL_PRODUCTION_DBP_DATA.WUP_2;