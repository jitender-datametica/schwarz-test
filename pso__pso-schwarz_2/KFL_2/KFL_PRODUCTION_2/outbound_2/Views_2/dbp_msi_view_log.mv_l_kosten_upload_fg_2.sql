CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_kosten_upload_fg_2 (kosten_upload_fg, kosten_upload_fg_bez) AS
(SELECT - 1 AS kosten_upload_fg,
  'nicht definiert / not defined' AS kosten_upload_fg_bez
 UNION DISTINCT
 SELECT 1 AS kosten_upload_fg,
  'Km-basiert' AS kosten_upload_fg_bez)
UNION DISTINCT
SELECT 0 AS kosten_upload_fg,
 'Kosten-basiert' AS kosten_upload_fg_bez;