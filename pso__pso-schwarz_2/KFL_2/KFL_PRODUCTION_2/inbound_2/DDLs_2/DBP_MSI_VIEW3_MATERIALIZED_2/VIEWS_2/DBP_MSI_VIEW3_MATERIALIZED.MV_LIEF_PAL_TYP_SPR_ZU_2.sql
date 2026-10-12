create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LIEF_PAL_TYP_SPR_ZU_2(
	LIEF_PAL_TYP_BEZ,
	LIEF_PAL_TYP_ID,
	MANDANT_ID,
	SPR_ID
) as
-- #613296 Splitt Palettentyp 6 in 61 und 64 - sschuecke 10.06.2015
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
 v01.lief_pal_typ_bez
,v01.lief_pal_typ_id
,v01.mandant_id
,v01.spr_id
FROM

(
SELECT
lief_pal_typ_bez
,Cast(lief_pal_typ_id AS VARCHAR(2)) lief_pal_typ_id
--,trycast(lief_pal_typ_id AS BYTEINT)  AS lief_pal_typ_id
,mandant_id
,spr_id

FROM DBP_VIEW.v_lief_pal_typ_spr_zu_2
--WHERE trycast(lief_pal_typ_id AS BYTEINT) IS NOT NULL

UNION

SELECT
'Mix on GP_2 - GP_2 Anteil' AS lief_pal_typ_bez
--,61 AS lief_pal_typ_id
,Cast('61' AS VARCHAR(2)) AS lief_pal_typ_id
,mandant_id
,spr_id

FROM DBP_VIEW.v_lief_pal_typ_spr_zu_2
/*JOIN dbp_msi.akt_msi_user_spr_zu_2 v04
ON v02.spr_id = v04.spr_id*/

UNION

SELECT
'Mix on GP_2 - MP Anteil' AS lief_pal_typ_bez
--,64 AS lief_pal_typ_id
,Cast('64' AS VARCHAR(2)) AS lief_pal_typ_id
,mandant_id
,spr_id

FROM DBP_VIEW.v_lief_pal_typ_spr_zu_2
) v01

JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02
ON v01.spr_id = v02.spr_id;