--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT CASE
  WHEN MANDANT_KBEZ = 'D'
  THEN 'DE'
  ELSE MANDANT_KBEZ
  END AS LAND_ID,
 MANDANT_ID
FROM KFL_PRODUCTION_DBP_DATA.MANDANT_2;