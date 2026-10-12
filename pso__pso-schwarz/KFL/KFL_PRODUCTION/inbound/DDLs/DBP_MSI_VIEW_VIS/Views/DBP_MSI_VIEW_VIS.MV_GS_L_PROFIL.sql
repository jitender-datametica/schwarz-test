CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_PROFIL as
   -- LOOKUP Geschenk-karten Profil
   -- 2011KW46 Initial

   SELECT
   v01.mandant_id, v01.profil_id
   FROM dbp_view.v_l_profil  v01;