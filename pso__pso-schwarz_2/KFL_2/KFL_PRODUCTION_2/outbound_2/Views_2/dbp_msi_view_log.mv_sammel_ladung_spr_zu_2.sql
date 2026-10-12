CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_sammel_ladung_spr_zu_2 (sammel_ladung_fg, sammel_ladung_bez) AS
SELECT sammel_ladung_fg,
 sammel_ladung_bez
FROM kfl_production_dbp_view.v_sammel_ladung_spr_zu_2 AS V01
GROUP BY sammel_ladung_fg,
 sammel_ladung_bez;