--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT LAND_ID,
 MAX(REGION_ID)
FROM KFL_PRODUCTION_DBP_DATA.REGION_1
GROUP BY LAND_ID;