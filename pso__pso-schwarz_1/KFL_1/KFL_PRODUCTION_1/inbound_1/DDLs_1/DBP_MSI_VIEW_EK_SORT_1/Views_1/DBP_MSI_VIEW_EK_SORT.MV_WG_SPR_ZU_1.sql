CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_WG_SPR_ZU_1
AS

   SELECT
   v01.wg_id, v01.mandant_id, COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.wg_bez  END),'N/A') AS wg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.wg_bez END),'N/A') AS wg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_bg  -- BG
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.wg_bez END), wg_bez_de) AS wg_bez_ro   -- RO

   FROM dbp_view.v_wg_spr_zu_1 v01
   JOIN dbp_view.v_wg_filter_zu_1 v02
   ON v01.mandant_id = v02.mandant_id AND v01.wg_id = v02.wg_id
   WHERE  v02.wg_filter_id = 11
   GROUP BY v01.wg_id, v01.mandant_id

   UNION

   SELECT
   -1  AS wg_id, mandant_id, 'N/A' AS wg_bez                                                             -- Standard == DE
   , 'N/A' AS wg_bez_de                                                     -- DE
   , 'N/A' AS wg_bez_bg    -- BG
   , 'N/A' AS wg_bez_cz  -- CZ
   , 'N/A' AS wg_bez_sk -- SK
   , 'N/A' AS wg_bez_hr    -- HR
   , 'N/A' AS wg_bez_pl    -- PL
   , 'N/A' AS wg_bez_ro   -- RO

   FROM dbp_view.v_mandant_1;