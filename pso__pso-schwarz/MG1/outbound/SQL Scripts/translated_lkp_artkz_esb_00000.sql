--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 ESB_ID
FROM KFL_PRODUCTION_DBP_DATA.ARTKZ_ESB
ORDER BY MANDANT_ID NULLS LAST,
 ESB_ID NULLS LAST;