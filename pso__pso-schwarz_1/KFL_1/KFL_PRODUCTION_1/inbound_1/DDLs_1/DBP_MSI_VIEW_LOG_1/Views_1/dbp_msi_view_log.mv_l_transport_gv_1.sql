CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TRANSPORT_GV_1(
	TRANSPORT_GV_ID
) AS
-- 2022-10-07, AP0145540, SPEC0169641, initial, dknop
   SELECT
   transport_gv_id
   FROM dbp_view.v_l_transport_gv_1
   GROUP BY transport_gv_id
;