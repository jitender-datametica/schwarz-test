CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_VIS_LU_1 as
   -- LOOKUP/SPRACHE : Inventurart VIS (Reporting)
   -- Mapping in dbx_msi_view_vis.mv_inventurart_int_vis_zu_1
   -- 2019.1118 ssch0611 : Initial (Inventuren pro Artikel_1)
   -- 2019.1218 ssch0611 : Finetuning

   SELECT DISTINCT
   vis.inventurart_vis_id, Max(CASE WHEN abt.spr_id = 22 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez, Max(CASE WHEN abt.spr_id = 124 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez_cz, Max(CASE WHEN abt.spr_id = 108 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez_sk, Max(CASE WHEN abt.spr_id = 65 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez_hr, Max(CASE WHEN abt.spr_id = 90 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'NGT'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez_pl, Max(CASE WHEN abt.spr_id = 95 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez_ro, Max(CASE WHEN abt.spr_id = 18 THEN CASE
   WHEN vis.inventurart_vis_id IN (10) THEN abt_bez
   WHEN vis.inventurart_vis_id IN (13) THEN 'OWG'
   ELSE inventurart_int_bez
   END END) AS inventurart_vis_bez_bg
   FROM dbp_msi_view_vis.mv_inventurart_int_vis_zu_1 vis

   JOIN dbp_view.v_abt_spr_zu_1 abt_1
   ON vis.abt_id = abt.abt_id

   JOIN dbp_view.v_inventurart_int_spr_zu_1 inv
   ON vis.inventurart_int_id = inv.inventurart_int_id AND abt.spr_id = inv.spr_id

   GROUP BY vis.inventurart_vis_id;