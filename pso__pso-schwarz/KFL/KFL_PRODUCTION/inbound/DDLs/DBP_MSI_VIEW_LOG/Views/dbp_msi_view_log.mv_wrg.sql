CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wrg  ( wrg_id, wrg_bez )
AS
SELECT
wrg_id,
wrg_bez
FROM dbp_view.v_wrg;
