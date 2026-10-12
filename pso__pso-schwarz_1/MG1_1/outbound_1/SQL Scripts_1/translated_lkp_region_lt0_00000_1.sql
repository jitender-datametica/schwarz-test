--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 LAND_ID,
 REGION_ID,
 SAP_REGION_ID
FROM KFL_PRODUCTION_DBP_DATA.REGION_1
WHERE REGION_ID < 0;