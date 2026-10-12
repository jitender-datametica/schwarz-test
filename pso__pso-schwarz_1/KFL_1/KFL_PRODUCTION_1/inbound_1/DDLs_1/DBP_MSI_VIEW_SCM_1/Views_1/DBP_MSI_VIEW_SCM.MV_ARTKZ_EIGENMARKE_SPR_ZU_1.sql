CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTKZ_EIGENMARKE_SPR_ZU_1 as
   SELECT
   mandant_id, eigenmarke_id, MAX(CASE WHEN spr_id=22 THEN eigenmarke_bez END ) AS eigenmarke_bez                                         -- standard == DE
   , MAX(CASE WHEN spr_id=22 THEN eigenmarke_bez END) AS eigenmarke_bez_de                                 -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_pl      -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_bg    -- BG
   FROM dbp_view.v_artkz_eigenmarke_1
   GROUP BY
   mandant_id
   , eigenmarke_id;