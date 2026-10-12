CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_MASSNAHME as
   SELECT
  v01.geku_massnahme_uid, v01.geku_massnahme_id
   FROM dbp_view.v_l_geku_massnahme v01;