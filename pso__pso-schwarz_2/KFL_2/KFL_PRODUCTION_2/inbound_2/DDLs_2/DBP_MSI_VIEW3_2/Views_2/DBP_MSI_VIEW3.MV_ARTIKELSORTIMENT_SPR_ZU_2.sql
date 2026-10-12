CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ARTIKELSORTIMENT_SPR_ZU_2(
	ARTIKELSORTIMENT_ID,
	ARTIKELSORTIMENT_BEZ,
	ARTIKELSORTIMENT_BEZ_DE,
	ARTIKELSORTIMENT_BEZ_CZ,
	ARTIKELSORTIMENT_BEZ_SK,
	ARTIKELSORTIMENT_BEZ_HR,
	ARTIKELSORTIMENT_BEZ_PL,
	ARTIKELSORTIMENT_BEZ_RO,
	ARTIKELSORTIMENT_BEZ_BG
) AS
--2022-06-07, AP0094047,SPEC0148298, dknop, initial
--2022-06-09, AP0094047,SPEC0148298, dknop, adding dummy_2 record
SELECT
 CAST(v01.artikelsortiment_id AS CHAR(2)) AS artikelsortiment_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.artikelsortiment_bez END) AS artikelsortiment_bez -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.artikelsortiment_bez END) AS artikelsortiment_bez_de -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_cz -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_sk -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_hr -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_pl -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_ro -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_bg -- BG
FROM dbp_view.v_artikelsortiment_spr_zu_2 v01
GROUP BY
artikelsortiment_id

UNION

SELECT
 '-1'  AS artikelsortiment_id
,'N/A' AS artikelsortiment_bez
,'N/A' AS artikelsortiment_bez_de -- DE
,'N/A' AS artikelsortiment_bez_cz -- CZ
,'N/A' AS artikelsortiment_bez_sk -- SK
,'N/A' AS artikelsortiment_bez_hr -- HR
,'N/A' AS artikelsortiment_bez_pl -- PL
,'N/A' AS artikelsortiment_bez_ro -- RO
,'N/A' AS artikelsortiment_bez_bg -- BG
FROM dbp_view.v_artikelsortiment_spr_zu_2 v01
GROUP BY
artikelsortiment_id
;