CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tp_objekt_status_per_agg_2 (tp_objekt_id, mandant_id,
tp_objekt_status_id_agg, tp_objekt_status_kbez_agg, tp_objekt_status_kbez_de_agg, tp_objekt_status_kbez_cz_agg,
tp_objekt_status_kbez_sk_agg, tp_objekt_status_kbez_hr_agg, tp_objekt_status_kbez_pl_agg, tp_objekt_status_kbez_ro_agg,
tp_objekt_status_kbez_bg_agg) AS SELECT TP_OBJ_S.tp_objekt_id,
 TP_OBJ_S.mandant_id,
 STRING_AGG(TP_OBJ_S.tp_objekt_status_id, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez IS NULL, tp_obj_s_spr.tp_objekt_status_kbez
   ) AS tp_objekt_status_id_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez IS NULL, tp_obj_s_spr.tp_objekt_status_kbez
   ) AS tp_objekt_status_kbez_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_de, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_de IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_de) AS tp_objekt_status_kbez_de_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_cz, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_cz IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_cz) AS tp_objekt_status_kbez_cz_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_sk, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_sk IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_sk) AS tp_objekt_status_kbez_sk_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_hr, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_hr IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_hr) AS tp_objekt_status_kbez_hr_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_pl, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_pl IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_pl) AS tp_objekt_status_kbez_pl_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_ro, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_ro IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_ro) AS tp_objekt_status_kbez_ro_agg,
 STRING_AGG(tp_obj_s_spr.tp_objekt_status_kbez_bg, ' ' ORDER BY tp_obj_s_spr.tp_objekt_status_kbez_bg IS NULL,
   tp_obj_s_spr.tp_objekt_status_kbez_bg) AS tp_objekt_status_kbez_bg_agg
FROM kfl_production_dbp_view.v_tp_objekt_status_per_2 AS TP_OBJ_S
 INNER JOIN (SELECT mandant_id,
   tp_objekt_status_id,
   MAX(CASE
     WHEN spr_id = 22
     THEN tp_objekt_status_kbez
     ELSE NULL
     END) AS tp_objekt_status_kbez,
   MAX(CASE
     WHEN spr_id = 22
     THEN tp_objekt_status_kbez
     ELSE NULL
     END) AS tp_objekt_status_kbez_de,
   COALESCE(MAX(CASE
      WHEN spr_id = 124
      THEN tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_cz,
   COALESCE(MAX(CASE
      WHEN spr_id = 108
      THEN tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_sk,
   COALESCE(MAX(CASE
      WHEN spr_id = 65
      THEN tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_hr,
   COALESCE(MAX(CASE
      WHEN spr_id = 90
      THEN tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_pl,
   COALESCE(MAX(CASE
      WHEN spr_id = 95
      THEN tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_ro,
   COALESCE(MAX(CASE
      WHEN spr_id = 18
      THEN tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_bg
  FROM kfl_production_dbp_view.v_tp_objekt_status_spr_zu_2 AS TP_OBJ_S_SPR
  GROUP BY mandant_id,
   tp_objekt_status_id) AS tp_obj_s_spr ON TP_OBJ_S.mandant_id = tp_obj_s_spr.mandant_id AND TP_OBJ_S.tp_objekt_status_id
    = tp_obj_s_spr.tp_objekt_status_id
WHERE TP_OBJ_S.tp_objekt_status_fg = 0
 AND TP_OBJ_S.dat_bis = DATE '9999-12-31'
GROUP BY TP_OBJ_S.tp_objekt_id,
 TP_OBJ_S.mandant_id;