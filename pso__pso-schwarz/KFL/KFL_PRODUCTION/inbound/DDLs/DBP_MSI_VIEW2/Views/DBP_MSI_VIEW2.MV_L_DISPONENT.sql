CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_DISPONENT
(
disponent_id
,mandant_id

)
AS
   SELECT
  disponent_id, mandant_id

   FROM dbp_view.v_l_disponent
   WHERE mandant_id = 1;