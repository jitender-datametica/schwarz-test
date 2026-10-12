CREATE OR REPLACE RECURSIVE VIEW DBP_MSI_VIEW_VIS.MV_HYG_THEMA_2
(
frage_katalog_id
, hyg_thema_mutter_id
, hyg_thema_id
, hyg_thema_ebene
, hyg_thema_sort_id
, gj
)
AS
WITH cte
AS (
   SELECT
   frage_katalog_id, 
   hyg_thema_mutter_id, 
   hyg_thema_id, 
   1 hyg_thema_ebene, 
   CAST(1 AS DECIMAL(13,12)) hyg_thema_sort_id, 
   gj
   FROM dbp_view.v_hyg_thema_2
   WHERE hyg_thema_id = frage_katalog_id -- Top Knoten
  
   UNION ALL
  
   SELECT
   th.frage_katalog_id, 
   th.hyg_thema_mutter_id, 
   th.hyg_thema_id, 
   rec.hyg_thema_ebene + 1  AS hyg_thema_ebene_,
   rec.hyg_thema_sort_id + CAST(th.hyg_thema_pos_id / (POWER(10, (rec.hyg_thema_ebene*2))) AS DECIMAL(13,12)),
   th.gj
   FROM dbp_view.v_hyg_thema_2 th
   INNER JOIN cte rec
   ON th.hyg_thema_mutter_id = rec.hyg_thema_id
   AND th.frage_katalog_id = rec.frage_katalog_id
   AND th.gj = rec.gj
)
   
   SELECT
   frage_katalog_id, 
   hyg_thema_mutter_id, 
   hyg_thema_id, 
   hyg_thema_ebene, 
   hyg_thema_sort_id, 
   gj
   FROM cte;