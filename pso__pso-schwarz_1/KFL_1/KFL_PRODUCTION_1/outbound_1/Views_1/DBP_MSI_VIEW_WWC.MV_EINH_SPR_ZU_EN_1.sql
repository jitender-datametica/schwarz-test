CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_einh_spr_zu_en_1 (einh_id, mandant_id, spr_id, einh_bez_kaufm,
einh_bez) AS SELECT einh_id,
 mandant_id,
 spr_id_0 AS spr_id,
 COALESCE(a0, a0_0) AS einh_bez_kaufm,
 einh_bez
FROM (SELECT mandant_id,
   einh_id,
   spr_id,
   einh_bez_kaufm,
   einh_bez,
   MAX(spr_id) AS spr_id_0,
   MAX(CASE
     WHEN spr_id = 24
     THEN einh_bez_kaufm
     ELSE NULL
     END) AS a0,
   MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END) AS a0_0
  FROM kfl_production_dbp_view.v_einh_spr_zu_1
  WHERE spr_id IN (22, 24)
  GROUP BY mandant_id,
   einh_id,
   spr_id,
   einh_bez_kaufm,
   einh_bez) AS t1_1;