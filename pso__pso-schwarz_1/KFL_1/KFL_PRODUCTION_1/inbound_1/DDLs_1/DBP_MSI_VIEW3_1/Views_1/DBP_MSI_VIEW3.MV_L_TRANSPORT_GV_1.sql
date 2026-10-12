CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_TRANSPORT_GV_1
(
mandant_id
,transport_gv_id
)
AS
   SELECT
   mandant_id, transport_gv_id
   FROM dbp_view.v_l_transport_gv_1
;