CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sb_schwellwert_wtag_1 AS SELECT mandant_id,
 wtag_id,
 vertrieb_fg,
 sw_rot_bis,
 sw_gelb_bis,
 sw_gelb_ab,
 sw_rot_ab,
 sw_soll
FROM kfl_production_dbp_data.sb_schwellwert_wtag_1;