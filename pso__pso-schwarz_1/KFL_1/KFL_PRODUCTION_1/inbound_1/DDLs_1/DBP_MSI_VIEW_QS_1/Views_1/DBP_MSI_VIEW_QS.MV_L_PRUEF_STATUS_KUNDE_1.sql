CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_L_PRUEF_STATUS_KUNDE_1
(
pruef_status_kunde
, pruef_status_kunde_bez
)
AS
SELECT
v01.pruef_status_id
, v01.pruef_status_bez

FROM dbp_view.v_l_pruef_status_1 v01;