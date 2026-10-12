--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 ART_ID,
 WG_ID
FROM KFL_PRODUCTION_DBP_DATA.ART_WG_ZU_PER
WHERE ARTHIERTYP_ID = 2
 AND DAT_BIS = PARSE_DATE('%F', '9999-12-31');