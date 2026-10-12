--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 POSTEN_ID
FROM KFL_PRODUCTION_DBP_DATA.ARTKZ_POSTEN_1
ORDER BY MANDANT_ID NULLS LAST,
 POSTEN_ID NULLS LAST;