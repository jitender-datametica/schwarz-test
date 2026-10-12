CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_WE_STATUS
(
we_status_id
,we_status_bez
)
AS
   SELECT
   we_status_id, we_status_bez
   FROM dbp_view.v_l_we_status
;