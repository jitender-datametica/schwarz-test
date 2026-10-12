CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_D_PEP_PLAN_TAG_1 as
   SELECT

   mandant_id, wup_id, dat_plan, ums_brutto_plan_man

   FROM dbp_dialog.d_pep_plan_tag_1;