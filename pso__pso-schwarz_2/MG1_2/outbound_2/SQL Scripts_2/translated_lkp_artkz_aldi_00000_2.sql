--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 ALDI_ID
FROM KFL_PRODUCTION_DBP_DATA.ARTKZ_ALDI_2
ORDER BY MANDANT_ID NULLS LAST,
 ALDI_ID NULLS LAST;