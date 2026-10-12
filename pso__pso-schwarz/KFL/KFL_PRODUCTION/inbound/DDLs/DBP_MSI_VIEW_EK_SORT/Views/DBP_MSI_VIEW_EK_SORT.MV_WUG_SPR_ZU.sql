CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_WUG_SPR_ZU
AS

   SELECT
   v01.mandant_id, v01.wug_id, v01.wg_id, COALESCE(MAX(CASE WHEN spr_id =  22  THEN v01.wug_bez END),'N/A') AS wug_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN spr_id =  22  THEN v01.wug_bez END),'N/A') AS wug_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN spr_id =  18  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_bg    -- BG
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v01.wug_bez END), wug_bez_de) AS wug_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95  THEN v01.wug_bez END), wug_bez_de) AS wug_bez_ro   -- RO

   FROM dbp_view.v_wug_spr_zu v01
   JOIN dbp_view.v_wg_filter_zu v02
   ON v01.mandant_id = v02.mandant_id AND v01.wg_id = v02.wg_id
   WHERE  v02.wg_filter_id = 11
   GROUP BY v01.mandant_id, v01.wug_id, v01.wg_id

   UNION

   SELECT
   mandant_id, -1  AS wug_id, -1  AS wg_id, 'N/A' AS wug_bez                                                             -- Standard == DE
   , 'N/A' AS wug_bez_de                                                     -- DE
   , 'N/A' AS wug_bez_bg    -- BG
   , 'N/A' AS wug_bez_cz  -- CZ
   , 'N/A' AS wug_bez_sk -- SK
   , 'N/A' AS wug_bez_hr    -- HR
   , 'N/A' AS wug_bez_pl    -- PL
   , 'N/A' AS wug_bez_ro   -- RO

   FROM dbp_view.v_mandant;