CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_BELOS_VORGANGART_1
(
mandant_id
,belos_vorgangart_id
)
AS
   SELECT
  mandant_id, belos_vorgangart_id

   FROM dbp_view.v_l_belos_vorgangart_1;