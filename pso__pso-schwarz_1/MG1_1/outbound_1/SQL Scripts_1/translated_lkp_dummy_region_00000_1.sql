--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT LAND_ID,
 MANDANT_ID,
 REGION_ID
FROM KFL_PRODUCTION_DBP_DATA.REGION_1
WHERE SAP_REGION_ID IN ('-', '-1');