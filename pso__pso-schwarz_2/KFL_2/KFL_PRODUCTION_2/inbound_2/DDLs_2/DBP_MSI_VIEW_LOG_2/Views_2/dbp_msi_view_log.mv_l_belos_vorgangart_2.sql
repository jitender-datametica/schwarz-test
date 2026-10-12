CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_BELOS_VORGANGART_2(
  BELOS_VORGANGART_ID)
  --2023-06-26, dknop, initial
  AS
  SELECT
  belos_vorgangart_id 
  FROM dbp_view.v_l_belos_vorgangart_2
  GROUP BY belos_vorgangart_id;