--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 ART_ID,
 BASISMENGE_EINH_ID
FROM KFL_PRODUCTION_DBP_DATA.ART_2
WHERE MANDANT_ID <> 1;