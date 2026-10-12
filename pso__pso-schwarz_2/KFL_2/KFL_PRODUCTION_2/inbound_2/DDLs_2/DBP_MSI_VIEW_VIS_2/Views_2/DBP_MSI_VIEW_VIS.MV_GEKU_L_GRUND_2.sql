CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_GRUND_2 as
   SELECT
  v01.geku_grund_uid, v01.geku_grund_id, v01.geku_bereich_uid
   FROM dbp_view.v_l_geku_grund_2 v01;