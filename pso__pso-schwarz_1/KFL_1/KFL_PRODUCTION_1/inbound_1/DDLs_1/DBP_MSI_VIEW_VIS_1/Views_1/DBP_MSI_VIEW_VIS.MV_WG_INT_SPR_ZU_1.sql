CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WG_INT_SPR_ZU_1
AS
-- SPRACHE : Warengruppen International
-- 2018.09 : WG Refresh

SELECT DISTINCT
wg.arthiertyp_id
, wg.wg_id
, MAX(CASE WHEN spr_id = 22 THEN wg_bez ELSE TRIM(wg_id) END) AS wg_bez_de -- DE   
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), wg_bez_de) AS wg_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), wg_bez_de) AS wg_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN wg_bez END), wg_bez_de) AS wg_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN wg_bez END), wg_bez_de) AS wg_bez_bg    -- BG
, wg_bez_de                                                    AS wg_bez    
FROM dbp_view.v_wg_spr_zu_1  wg
WHERE wg.arthiertyp_id = 2
GROUP BY arthiertyp_id, wg_id;