CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IT_PLAN_EBENE_SPR_ZU_RO_2 AS
-- 08.04.2013 AL init
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.it_plan_ebene_id,
   COALESCE(ls.it_plan_ebene_kbez, de.it_plan_ebene_kbez) AS it_plan_ebene_kbez,
   COALESCE(ls.it_plan_ebene_bez, de.it_plan_ebene_bez) AS it_plan_ebene_bez

   FROM dbp_view.v_it_plan_ebene_spr_zu_2   de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_it_plan_ebene_spr_zu_2
   WHERE spr_id = 95
   ) ls
   ON de.it_plan_ebene_id = ls.it_plan_ebene_id

   WHERE de.spr_id = 22
   ;