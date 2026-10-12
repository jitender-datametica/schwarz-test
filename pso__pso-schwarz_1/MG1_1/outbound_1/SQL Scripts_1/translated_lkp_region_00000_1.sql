--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 LAND_ID,
 REGION_ID,
 TRIM(SAP_REGION_ID) AS SAP_REGION_ID,
 REGION_NAME
FROM KFL_PRODUCTION_DBP_DATA.REGION_1;