CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_WRG
(
wrg_id
, wrg_bez
)
AS
SELECT
v01.wrg_id
, v01.wrg_bez

FROM dbp_view.v_wrg v01;