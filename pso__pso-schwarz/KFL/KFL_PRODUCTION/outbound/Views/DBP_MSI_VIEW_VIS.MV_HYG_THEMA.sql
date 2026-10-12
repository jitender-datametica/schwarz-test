CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_thema AS WITH recursive CTE AS (SELECT frage_katalog_id,
    hyg_thema_mutter_id,
    hyg_thema_id,
    1 AS hyg_thema_ebene,
    cast (1 as BIGNUMERIC) AS hyg_thema_sort_id,
    gj
   FROM kfl_production_dbp_view.v_hyg_thema
   WHERE hyg_thema_id = frage_katalog_id -- Top Knoten

   UNION ALL
   SELECT TH.frage_katalog_id,
    TH.hyg_thema_mutter_id,
    TH.hyg_thema_id,
     REC.hyg_thema_ebene + 1 AS hyg_thema_ebene_,
     REC.hyg_thema_sort_id + CAST(TH.hyg_thema_pos_id / POWER(10, REC.hyg_thema_ebene * 2) AS BIGNUMERIC),
    TH.gj
   FROM kfl_production_dbp_view.v_hyg_thema AS TH
    INNER JOIN cte AS REC ON TH.hyg_thema_mutter_id = REC.hyg_thema_id AND TH.frage_katalog_id = REC.frage_katalog_id
     AND TH.gj = REC.gj) (SELECT frage_katalog_id,
   hyg_thema_mutter_id,
   hyg_thema_id,
   hyg_thema_ebene,
   hyg_thema_sort_id,
   gj
  FROM CTE);
