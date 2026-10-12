--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 LEIST_ID
FROM KFL_PRODUCTION_DBP_DATA.ARTKZ_LEIST
ORDER BY MANDANT_ID NULLS LAST,
 LEIST_ID NULLS LAST;