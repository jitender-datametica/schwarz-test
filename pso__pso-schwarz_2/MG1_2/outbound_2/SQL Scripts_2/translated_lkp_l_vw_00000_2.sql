--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 TRIM(SAP_VW_ID) AS SAP_VW_ID,
 VW_ID
FROM KFL_PRODUCTION_DBP_DATA.L_VW_2
ORDER BY 1 NULLS LAST,
 2 NULLS LAST;