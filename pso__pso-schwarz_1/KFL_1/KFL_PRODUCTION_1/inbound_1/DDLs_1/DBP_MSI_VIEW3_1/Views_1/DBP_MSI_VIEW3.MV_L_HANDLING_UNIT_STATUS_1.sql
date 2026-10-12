CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_HANDLING_UNIT_STATUS_1
(
mandant_id
,hu_status_id
)
AS
   SELECT
   mandant_id, hu_status_id
   FROM dbp_view.v_l_handling_unit_status_1;