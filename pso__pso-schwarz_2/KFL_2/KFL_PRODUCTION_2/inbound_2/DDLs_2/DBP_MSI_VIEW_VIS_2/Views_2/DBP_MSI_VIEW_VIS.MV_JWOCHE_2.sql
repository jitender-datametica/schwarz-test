CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_JWOCHE_2(
JWO,
JWO_IST,
JWO_BEZ,
JWO_BEZ_DE,
JWO_BEZ_CZ,
JWO_BEZ_SK,
JWO_BEZ_HR,
JWO_BEZ_PL,
JWO_BEZ_RO,
JWO_BEZ_BG
) AS 
 
/*
	2025-01-24 muellerpatri : Initiale Erstellung der View
*/

SELECT DISTINCT
CAST(MOD(v01.kjwo,100) AS INTEGER)               AS jwo
, TO_VARCHAR(jwo, '00')                          AS jkw_ist
, CAST('KW' || jkw_ist AS VARCHAR(20))           AS jkw_bez      --standard (DE)
, CAST('KW' || jkw_ist AS VARCHAR(20))           AS jkw_bez_de   --deutsch
, CAST('KT' || jkw_ist AS VARCHAR(20))           AS jkw_bez_cz   --tschechisch
, CAST('KW' || jkw_ist AS VARCHAR(20))           AS jkw_bez_sk   --slowakisch
, CAST('KW' || jkw_ist AS VARCHAR(20))           AS jkw_bez_hr   --kroatisch
, CAST('KW' || jkw_ist AS VARCHAR(20))           AS jkw_bez_pl   --polnisch
, CAST('KW' || jkw_ist AS VARCHAR(20))           AS jkw_bez_ro   --rumänisch
, CAST('КС' || jkw_ist AS VARCHAR(20))           AS jkw_bez_bg   --bulgarisch 
FROM
dbp_view.v_woche_2 v01
;