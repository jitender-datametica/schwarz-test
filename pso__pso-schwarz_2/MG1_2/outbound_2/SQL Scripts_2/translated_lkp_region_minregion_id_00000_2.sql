--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT IFNULL(MAX(REGION_ID), 0) AS MIN_REGION_ID
FROM KFL_PRODUCTION_DBP_DATA.REGION_2;