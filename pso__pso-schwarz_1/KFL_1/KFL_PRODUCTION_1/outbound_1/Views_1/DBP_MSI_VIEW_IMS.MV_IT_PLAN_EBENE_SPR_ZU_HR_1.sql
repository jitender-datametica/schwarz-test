CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_it_plan_ebene_spr_zu_hr_1 AS SELECT DE.it_plan_ebene_id,
 COALESCE(ls.it_plan_ebene_kbez, DE.it_plan_ebene_kbez) AS it_plan_ebene_kbez,
 COALESCE(ls.it_plan_ebene_bez, DE.it_plan_ebene_bez) AS it_plan_ebene_bez
FROM kfl_production_dbp_view.v_it_plan_ebene_spr_zu_1 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_it_plan_ebene_spr_zu_1
  WHERE spr_id = 65) AS ls ON DE.it_plan_ebene_id = ls.it_plan_ebene_id
WHERE DE.spr_id = 22;