--[OK] statement is translated correctly (syntax and type checks are fine)



SELECT MANDANT_ID,
 TRIM(LAGERNUMMER_ID) AS LAGERNUMMER_ID,
 WUP_ID,
 NB_ID,
 OUG_FG
FROM KFL_PRODUCTION_DBP_DATA.L_LAGERNUMMER_1;