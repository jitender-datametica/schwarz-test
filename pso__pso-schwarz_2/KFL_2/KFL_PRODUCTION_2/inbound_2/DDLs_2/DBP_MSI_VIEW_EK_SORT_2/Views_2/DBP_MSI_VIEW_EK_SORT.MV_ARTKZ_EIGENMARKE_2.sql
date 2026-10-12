CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_ARTKZ_EIGENMARKE_2
AS

   SELECT * FROM (
   SELECT
   '-1' AS eigenmarke_id, 'Potenzial Eigenmarke' AS eigenmarke_bez, 'Potenzial Eigenmarke' AS eigenmarke_bez_de, 'Potenzial Eigenmarke' AS eigenmarke_bez_cz, 'Potenzial Eigenmarke' AS eigenmarke_bez_sk, 'Potenzial Eigenmarke' AS eigenmarke_bez_hr, 'Potenzial Eigenmarke' AS eigenmarke_bez_pl, 'Potenzial Eigenmarke' AS eigenmarke_bez_ro, 'Potenzial Eigenmarke' AS eigenmarke_bez_bg) y

   UNION ALL

   SELECT
   v01.eigenmarke_id, COALESCE(MAX(CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END), 'N/A') AS eigenmarke_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END), 'N/A') AS eigenmarke_bez_de                                                     -- DE
   , MAX(COALESCE(CASE WHEN spr_id = 124 AND mandant_id = 2 THEN eigenmarke_bez END, CASE WHEN spr_id = 22 AND mandant_id = 2 THEN eigenmarke_bez END, CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END)) AS eigenmarke_bez_cz  -- CZ
   , MAX(COALESCE(CASE WHEN spr_id = 108 AND mandant_id = 5 THEN eigenmarke_bez END, CASE WHEN spr_id = 22 AND mandant_id = 5 THEN eigenmarke_bez END, CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END)) AS eigenmarke_bez_sk -- SK
   , MAX(COALESCE(CASE WHEN spr_id =  65  AND mandant_id = 6 THEN eigenmarke_bez END, CASE WHEN spr_id = 22 AND mandant_id = 6 THEN eigenmarke_bez END, CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END)) AS eigenmarke_bez_hr    -- HR
   , MAX(COALESCE(CASE WHEN spr_id =  90  AND mandant_id = 3 THEN eigenmarke_bez END, CASE WHEN spr_id = 22 AND mandant_id = 3 THEN eigenmarke_bez END, CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END)) AS eigenmarke_bez_pl    -- PL
   , MAX(COALESCE(CASE WHEN spr_id =  95  AND mandant_id = 7 THEN eigenmarke_bez END, CASE WHEN spr_id = 22 AND mandant_id = 7 THEN eigenmarke_bez END, CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END)) AS eigenmarke_bez_ro   -- RO
   , MAX(COALESCE(CASE WHEN spr_id =  18  AND mandant_id = 8 THEN eigenmarke_bez END, CASE WHEN spr_id = 22 AND mandant_id = 8 THEN eigenmarke_bez END, CASE WHEN spr_id =  22 AND mandant_id = 1 THEN eigenmarke_bez END)) AS eigenmarke_bez_bg  -- BG

   FROM dbp_view.v_artkz_eigenmarke_2 v01

   GROUP BY 1 --, 2, 3

   UNION ALL

   SELECT * FROM (
   SELECT
   '0' AS eigenmarke_id, 'Potenzial Marke' AS eigenmarke_bez, 'Potenzial Marke' AS eigenmarke_bez_de, 'Potenzial Marke' AS eigenmarke_bez_cz, 'Potenzial Marke' AS eigenmarke_bez_sk, 'Potenzial Marke' AS eigenmarke_bez_hr, 'Potenzial Marke' AS eigenmarke_bez_pl, 'Potenzial Marke' AS eigenmarke_bez_ro, 'Potenzial Marke' AS eigenmarke_bez_bg) x;