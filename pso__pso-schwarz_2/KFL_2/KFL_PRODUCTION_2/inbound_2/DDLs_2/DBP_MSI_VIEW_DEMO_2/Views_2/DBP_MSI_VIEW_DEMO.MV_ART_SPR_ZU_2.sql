CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_ART_SPR_ZU_2
AS
SELECT
v01.mandant_id,
v01.art_id,
MAX(CASE WHEN spr_id =  22 THEN art_bez END) AS art_bez                 -- standard == DE
,
MAX(CASE WHEN spr_id =  22 THEN art_bez END) AS art_bez_de                          -- DE
,
COALESCE(MAX(CASE WHEN spr_id = 124 THEN art_bez END), art_bez_de) AS art_bez_cz    -- CZ
,
COALESCE(MAX(CASE WHEN spr_id = 108 THEN art_bez END), art_bez_de) AS art_bez_sk    -- SK
,
COALESCE(MAX(CASE WHEN spr_id =  65 THEN art_bez END), art_bez_de) AS art_bez_hr    -- HR
,
COALESCE(MAX(CASE WHEN spr_id =  90 THEN art_bez END), art_bez_de) AS art_bez_pl    -- PL
,
COALESCE(MAX(CASE WHEN spr_id =  95 THEN art_bez END), art_bez_de) AS art_bez_ro    -- RO
,
COALESCE(MAX(CASE WHEN spr_id =  18 THEN art_bez END), art_bez_de) AS art_bez_bg    -- BG

FROM dbp_view.v_art_spr_zu_2 v01
GROUP BY
v01.mandant_id
, v01.art_id;






