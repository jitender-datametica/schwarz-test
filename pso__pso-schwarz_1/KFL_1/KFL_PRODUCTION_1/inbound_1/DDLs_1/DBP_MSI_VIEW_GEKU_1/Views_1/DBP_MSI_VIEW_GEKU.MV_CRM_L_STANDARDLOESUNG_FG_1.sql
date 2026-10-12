CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_STANDARDLOESUNG_FG_1
AS
-- 02.04.2020 lsvi: SPEC0064978 Lookup CRM Standardloesung Flag

   SELECT

   flag AS standardloesung_fg

   FROM dbp_view.v_flag_spr_zu_1  --keine Lookup vorhanden

   GROUP BY flag;