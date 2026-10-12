CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IT_PLAN_EBENE_SPR_ZU AS
-- 08.04.2013 AL init

   SELECT
   it_plan_ebene_id,
   it_plan_ebene_kbez,
   it_plan_ebene_bez

  FROM dbp_view.v_it_plan_ebene_spr_zu
  WHERE spr_id=22;