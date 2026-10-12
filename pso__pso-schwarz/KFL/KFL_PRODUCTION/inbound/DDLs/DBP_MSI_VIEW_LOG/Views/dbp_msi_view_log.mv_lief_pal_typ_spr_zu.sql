CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LIEF_PAL_TYP_SPR_ZU
--27.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage
--29.01.2021, SPEC0097379, AP0069430, dknop replacing with new solution, 61and 64 the same for all languages (should be updated)
--03.02.2021, nwag2310, pal typ char
--08.06.2021, SPEC0112147, AP0070892, dknop, adding empty value
--13.10.2023, nwag2310, J4+J9 added
AS
SELECT
lief_pal_typ_id AS lief_pal_typ_id,
MAX(CASE WHEN v01.spr_id = 22 THEN v01.lief_pal_typ_bez END) AS lief_pal_typ_bez                         -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.lief_pal_typ_bez END) AS lief_pal_typ_bez_de                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lief_pal_typ_bez END),lief_pal_typ_bez_de) AS lief_pal_typ_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lief_pal_typ_bez END),lief_pal_typ_bez_de) AS lief_pal_typ_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.lief_pal_typ_bez END),lief_pal_typ_bez_de) AS lief_pal_typ_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.lief_pal_typ_bez END),lief_pal_typ_bez_de) AS lief_pal_typ_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.lief_pal_typ_bez END),lief_pal_typ_bez_de) AS lief_pal_typ_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.lief_pal_typ_bez END),lief_pal_typ_bez_de) AS lief_pal_typ_bez_bg    -- BG
FROM dbp_view.v_lief_pal_typ_spr_zu v01
GROUP BY v01.lief_pal_typ_id

UNION
SELECT
'J4' AS lief_pal_typ_id,
'AKA Food MP' AS lief_pal_typ_bez,
'AKA Food MP' AS lief_pal_typ_bez_de,
'AKA Food MP' AS lief_pal_typ_bez_cz,
'AKA Food MP' AS lief_pal_typ_bez_sk,
'AKA Food MP' AS lief_pal_typ_bez_hr,
'AKA Food MP' AS lief_pal_typ_bez_pl,
'AKA Food MP' AS lief_pal_typ_bez_ro,
'AKA Food MP' AS lief_pal_typ_bez_bg
FROM dbp_view.v_lief_pal_typ_spr_zu

UNION
SELECT
'J9' AS lief_pal_typ_id,
'AKA Food KKP' AS lief_pal_typ_bez,
'AKA Food KKP' AS lief_pal_typ_bez_de,
'AKA Food KKP' AS lief_pal_typ_bez_cz,
'AKA Food KKP' AS lief_pal_typ_bez_sk,
'AKA Food KKP' AS lief_pal_typ_bez_hr,
'AKA Food KKP' AS lief_pal_typ_bez_pl,
'AKA Food KKP' AS lief_pal_typ_bez_ro,
'AKA Food KKP' AS lief_pal_typ_bez_bg
FROM dbp_view.v_lief_pal_typ_spr_zu

UNION
SELECT
'61' AS lief_pal_typ_id,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_de,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_cz,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_sk,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_hr,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_pl,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_ro,
'Mix on GP - GP Anteil' AS lief_pal_typ_bez_bg
FROM dbp_view.v_lief_pal_typ_spr_zu

UNION
SELECT
'64' AS lief_pal_typ_id,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_de,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_cz,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_sk,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_hr,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_pl,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_ro,
'Mix on GP - MP Anteil' AS lief_pal_typ_bez_bg
FROM dbp_view.v_lief_pal_typ_spr_zu

UNION
SELECT
'' AS lief_pal_typ_id,
'' AS lief_pal_typ_bez,
'' AS lief_pal_typ_bez_de,
'' AS lief_pal_typ_bez_cz,
'' AS lief_pal_typ_bez_sk,
'' AS lief_pal_typ_bez_hr,
'' AS lief_pal_typ_bez_pl,
'' AS lief_pal_typ_bez_ro,
'' AS lief_pal_typ_bez_bg
FROM dbp_view.v_lief_pal_typ_spr_zu;