CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_OWG_SPR_ZU_2
AS

   SELECT
   v01.owg_id, v01.mandant_id, COALESCE(MAX(CASE WHEN spr_id =  22 THEN v01.owg_bez  END),'N/A') AS owg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN spr_id =  22 THEN v01.owg_bez END),'N/A') AS owg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18  THEN v01.owg_bez END), owg_bez_de) AS owg_bez_bg  -- BG

   FROM dbp_view.v_owg_spr_zu_2 v01
   JOIN dbp_view.v_wg_per_2 v02
   ON v01.mandant_id = v02.mandant_id AND v01.owg_id = v02.owg_id
   JOIN dbp_view.v_wg_filter_zu_2 v03
   ON v02.mandant_id = v03.mandant_id AND v02.wg_id = v03.wg_id

   GROUP BY v01.owg_id, v01.mandant_id;