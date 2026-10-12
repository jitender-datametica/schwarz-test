CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LIS_REKL_STATUS
(
mandant_id
,lis_rekl_status_id
)
AS
   SELECT
   mandant_id, lis_rekl_status_id
   FROM dbp_view.v_l_lis_rekl_status;