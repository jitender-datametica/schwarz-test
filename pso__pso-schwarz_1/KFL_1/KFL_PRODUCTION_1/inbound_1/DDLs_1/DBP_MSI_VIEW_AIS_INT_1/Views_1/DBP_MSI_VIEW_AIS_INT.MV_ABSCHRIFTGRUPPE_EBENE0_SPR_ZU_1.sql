CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ABSCHRIFTGRUPPE_EBENE0_SPR_ZU_1
(
MANDANT_ID,
ABSCHRIFTGRUPPE_ID_EBENE0,
ABSCHRIFTGRUPPE_EBENE0_BEZ,
ABSCHRIFTGRUPPE_EBENE0_BEZ_DE,
ABSCHRIFTGRUPPE_EBENE0_BEZ_CZ,
ABSCHRIFTGRUPPE_EBENE0_BEZ_SK,
ABSCHRIFTGRUPPE_EBENE0_BEZ_HR,
ABSCHRIFTGRUPPE_EBENE0_BEZ_PL,
ABSCHRIFTGRUPPE_EBENE0_BEZ_RO,
ABSCHRIFTGRUPPE_EBENE0_BEZ_BG
)
AS
SELECT
 v01.mandant_id
 
--,spr_id
,v01.abschriftgruppe_id
,COALESCE (MAX(CASE WHEN spr_id = 22  THEN v01.abschriftgruppe_bez END), 'N/A') AS abschriftgruppe_ebene0_bez                     --Standard DE--
,COALESCE (MAX(CASE WHEN spr_id = 22  THEN v01.abschriftgruppe_bez END), 'N/A') AS abschriftgruppe_ebene0_bez_de                  --DE--
,COALESCE (MAX(CASE WHEN spr_id = 124 THEN v01.abschriftgruppe_bez END), abschriftgruppe_ebene0_bez_de) AS abschriftgruppe_ebene0_bez_cz --CZ--
,COALESCE (MAX(CASE WHEN spr_id = 108 THEN v01.abschriftgruppe_bez END), abschriftgruppe_ebene0_bez_de) AS abschriftgruppe_ebene0_bez_sk --SK--
,COALESCE (MAX(CASE WHEN spr_id = 65  THEN v01.abschriftgruppe_bez END), abschriftgruppe_ebene0_bez_de) AS abschriftgruppe_ebene0_bez_hr --HR--
,COALESCE (MAX(CASE WHEN spr_id = 90  THEN v01.abschriftgruppe_bez END), abschriftgruppe_ebene0_bez_de) AS abschriftgruppe_ebene0_bez_pl --PL--
,COALESCE (MAX(CASE WHEN spr_id = 95  THEN v01.abschriftgruppe_bez END), abschriftgruppe_ebene0_bez_de) AS abschriftgruppe_ebene0_bez_ro --RO--
,COALESCE (MAX(CASE WHEN spr_id = 18  THEN v01.abschriftgruppe_bez END), abschriftgruppe_ebene0_bez_de) AS abschriftgruppe_ebene0_bez_bg --BG--
--,abschriftgruppe_bez
FROM DBP_VIEW.V_ABSCHRIFTGRUPPE_SPR_ZU_1 v01
JOIN DBP_MSI_VIEW_AIS_INT.MV_ABSCHRIFTGRUPPE_EBENE0_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.abschriftgruppe_id = v02.abschriftgruppe_id_ebene0
GROUP BY
 v01.mandant_id
,v01.abschriftgruppe_id
;