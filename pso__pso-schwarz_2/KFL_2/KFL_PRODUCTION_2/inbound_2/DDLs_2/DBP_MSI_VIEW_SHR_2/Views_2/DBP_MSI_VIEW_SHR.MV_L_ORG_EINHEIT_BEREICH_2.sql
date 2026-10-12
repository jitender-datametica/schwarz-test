CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_ORG_EINHEIT_BEREICH_2 as
   SELECT

   mandant_id, hr_objekt_bereich_id

   FROM dbp_view.v_l_org_einheit_bereich_2;