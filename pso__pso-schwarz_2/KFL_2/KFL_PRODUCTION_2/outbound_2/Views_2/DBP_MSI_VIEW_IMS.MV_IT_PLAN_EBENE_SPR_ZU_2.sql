CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_it_plan_ebene_spr_zu_2 AS SELECT it_plan_ebene_id,
 it_plan_ebene_kbez,
 it_plan_ebene_bez
FROM kfl_production_dbp_view.v_it_plan_ebene_spr_zu_2
WHERE spr_id = 22;