CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SAISON as
   SELECT
   mandant_id, saison_id
   FROM dbp_view.v_l_saison;