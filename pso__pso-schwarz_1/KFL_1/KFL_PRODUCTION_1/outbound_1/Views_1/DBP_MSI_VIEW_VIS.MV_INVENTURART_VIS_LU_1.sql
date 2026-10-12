CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventurart_vis_lu_1 AS SELECT VIS.inventurart_vis_id,
 MAX(CASE
   WHEN ABT.spr_id = 22
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez,
 MAX(CASE
   WHEN ABT.spr_id = 124
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez_cz,
 MAX(CASE
   WHEN ABT.spr_id = 108
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez_sk,
 MAX(CASE
   WHEN ABT.spr_id = 65
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez_hr,
 MAX(CASE
   WHEN ABT.spr_id = 90
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'NGT'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez_pl,
 MAX(CASE
   WHEN ABT.spr_id = 95
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez_ro,
 MAX(CASE
   WHEN ABT.spr_id = 18
   THEN CASE
    WHEN VIS.inventurart_vis_id IN (10)
    THEN ABT.abt_bez
    WHEN VIS.inventurart_vis_id IN (13)
    THEN 'OWG'
    ELSE INV.inventurart_int_bez
    END
   ELSE NULL
   END) AS inventurart_vis_bez_bg
FROM kfl_production_dbp_msi_view_vis.mv_inventurart_int_vis_zu_1 AS VIS
 INNER JOIN kfl_production_dbp_view.v_abt_spr_zu_1 AS ABT_1 ON VIS.abt_id = ABT.abt_id
 INNER JOIN kfl_production_dbp_view.v_inventurart_int_spr_zu_1 AS INV ON VIS.inventurart_int_id = INV.inventurart_int_id
  AND ABT.spr_id = INV.spr_id
GROUP BY VIS.inventurart_vis_id;