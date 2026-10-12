CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_INT_SPR_ZU_2
AS
-- SPRACHE : Abteilung International
-- 2018.09 : OWG Struktur

SELECT
abt.arthiertyp_id
, abt.abt_id
, MAX(CASE WHEN spr_id =  22 THEN abt_bez ELSE TRIM(abt_id) END) AS abt_bez_de
, abt_bez_de                                                         AS abt_bez       -- DE
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN abt_bez END), abt_bez_de) AS abt_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN abt_bez END), abt_bez_de) AS abt_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN abt_bez END), abt_bez_de) AS abt_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN abt_bez END), abt_bez_de) AS abt_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN abt_bez END), abt_bez_de) AS abt_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN abt_bez END), abt_bez_de) AS abt_bez_bg    -- BG

FROM dbp_view.v_abt_spr_zu_2  abt_2
WHERE abt.arthiertyp_id = 2

GROUP BY arthiertyp_id, abt_id;