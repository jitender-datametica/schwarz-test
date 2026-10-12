CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_MASSNAHME_2 as
   SELECT
  v01.geku_massnahme_uid, v01.geku_massnahme_id
   FROM dbp_view.v_l_geku_massnahme_2 v01;