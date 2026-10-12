--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 WG_ID
FROM KFL_PRODUCTION_DBP_DATA.WG_PER
WHERE DAT_BIS = PARSE_DATE('%F', '9999-12-31')
 AND OWG_ID <> - 1;