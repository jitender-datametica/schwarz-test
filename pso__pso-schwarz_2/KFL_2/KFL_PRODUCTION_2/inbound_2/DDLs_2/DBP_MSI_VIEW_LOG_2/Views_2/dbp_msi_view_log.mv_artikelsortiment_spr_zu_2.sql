CREATE OR REPLACE VIEW  dbp_msi_view_log.MV_ARTIKELSORTIMENT_SPR_ZU_2
-- 2021-03-29, dknop, SPEC0107644, AP0081632, initial
-- 2021-07-14, dknop, SPEC0112147, AP0070892, 0 value for artikelsortiment_id null
-- 2021-07-26, dknop, SPEC0112147, AP0070892, removing 0 value for artikelsortiment_id null
-- 2021-03-07, dknop, adding lagernummer, mandnat
--  2022-06-09, AP0094047,SPEC0148298, adding dummy_2 record
-- 2022-11-29, AP0145540_SPEC0169641, dknop, adding lagernummer_les
AS
SELECT
 CAST(v01.artikelsortiment_id AS CHAR(2)) AS artikelsortiment_id
,v03.mandant_id
,v03.lagernummer_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.artikelsortiment_bez END) AS artikelsortiment_bez -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.artikelsortiment_bez END) AS artikelsortiment_bez_de -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_cz -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_sk -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_hr -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_pl -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_ro -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_bg -- BG
FROM dbp_view.v_artikelsortiment_spr_zu_2 v01
JOIN dbp_view.v_l_lagernummer_2 v03
ON v03.ewm_fg=1
GROUP BY v01.artikelsortiment_id, v03.mandant_id, v03.lagernummer_id

UNION

SELECT
 '-1'  AS artikelsortiment_id
 ,v03.mandant_id
 ,v03.lagernummer_id
,'N/A' AS artikelsortiment_bez
,'N/A' AS artikelsortiment_bez_de -- DE
,'N/A' AS artikelsortiment_bez_cz -- CZ
,'N/A' AS artikelsortiment_bez_sk -- SK
,'N/A' AS artikelsortiment_bez_hr -- HR
,'N/A' AS artikelsortiment_bez_pl -- PL
,'N/A' AS artikelsortiment_bez_ro -- RO
,'N/A' AS artikelsortiment_bez_bg -- BG

FROM dbp_view.v_artikelsortiment_spr_zu_2 v01
JOIN dbp_view.v_l_lagernummer_2 v03
ON v03.ewm_fg=1
GROUP BY v01.artikelsortiment_id, v03.mandant_id, v03.lagernummer_id

UNION

SELECT
 CAST(v01.artikelsortiment_id AS CHAR(2)) AS  artikelsortiment_id
,v03.mandant_id
,v03.lagernummer_les_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.artikelsortiment_bez END) AS artikelsortiment_bez -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.artikelsortiment_bez END) AS artikelsortiment_bez_de -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_cz -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_sk -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_hr -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_pl -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_ro -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.artikelsortiment_bez END),artikelsortiment_bez_de) AS artikelsortiment_bez_bg -- BG
FROM dbp_view.v_artikelsortiment_spr_zu_2 v01
JOIN dbp_view.v_ts_mercareon_mapping_2  v03

GROUP BY v01.artikelsortiment_id, v03.mandant_id, v03.lagernummer_les_id

UNION

SELECT
 '-1'  AS artikelsortiment_id
 ,v03.mandant_id
,v03.lagernummer_les_id
,'N/A' AS artikelsortiment_bez
,'N/A' AS artikelsortiment_bez_de -- DE
,'N/A' AS artikelsortiment_bez_cz -- CZ
,'N/A' AS artikelsortiment_bez_sk -- SK
,'N/A' AS artikelsortiment_bez_hr -- HR
,'N/A' AS artikelsortiment_bez_pl -- PL
,'N/A' AS artikelsortiment_bez_ro -- RO
,'N/A' AS artikelsortiment_bez_bg -- BG

FROM dbp_view.v_artikelsortiment_spr_zu_2 v01
JOIN dbp_view.v_ts_mercareon_mapping_2  v03

GROUP BY v01.artikelsortiment_id, v03.mandant_id, v03.lagernummer_les_id;