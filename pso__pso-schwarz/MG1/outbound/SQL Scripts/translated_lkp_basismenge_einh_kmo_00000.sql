--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 ART_ID,
 BASISMENGE_EINH_ID
FROM KFL_PRODUCTION_DBP_DATA.ART
WHERE MANDANT_ID <> 1;