CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LIS_REKL_GRUND
(
mandant_id
,lis_rekl_grund_id
)
AS
   SELECT
   mandant_id, lis_rekl_grund_id
   FROM dbp_view.v_l_lis_rekl_grund;