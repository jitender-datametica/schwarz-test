--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 REGION_NAME,
 MAX(REGION_ID) AS REGION_ID
FROM KFL_PRODUCTION_DBP_DATA.REGION_2
GROUP BY MANDANT_ID,
 REGION_NAME;