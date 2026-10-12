CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_SAISON_2 as
   SELECT
   mandant_id, saison_id
   FROM dbp_view.v_l_saison_2;