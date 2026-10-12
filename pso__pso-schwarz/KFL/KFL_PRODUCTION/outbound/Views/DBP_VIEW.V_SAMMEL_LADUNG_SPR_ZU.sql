CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sammel_ladung_spr_zu AS SELECT sammel_ladung_fg,
 spr_id,
 sammel_ladung_bez
FROM kfl_production_dbp_data.sammel_ladung_spr_zu;