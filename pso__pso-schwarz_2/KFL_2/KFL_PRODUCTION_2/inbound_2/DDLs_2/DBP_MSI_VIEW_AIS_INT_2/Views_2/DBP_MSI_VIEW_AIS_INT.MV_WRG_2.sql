CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WRG_2
(
WRG_ID,
WRG_BEZ
)
AS
SELECT
wrg_id,
wrg_bez
FROM dbp_view.v_wrg_2;                          