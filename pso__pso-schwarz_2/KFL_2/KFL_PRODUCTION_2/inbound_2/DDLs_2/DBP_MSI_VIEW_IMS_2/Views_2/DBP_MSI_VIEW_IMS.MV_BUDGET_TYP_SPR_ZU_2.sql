CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BUDGET_TYP_SPR_ZU_2 AS
-- 08.07.2014 twie: Erstellung Sprachview Budget Typ

   SELECT

   in_budget_typ_id,
   in_budget_typ_bez

   FROM dbp_view.v_in_budget_typ_spr_zu_2

   WHERE spr_id = 22;