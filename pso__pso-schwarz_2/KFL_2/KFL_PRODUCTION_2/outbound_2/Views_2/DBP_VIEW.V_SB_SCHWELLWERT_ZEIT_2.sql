CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sb_schwellwert_zeit_2 AS SELECT mandant_id,
 zeit_stunde_von,
 vertrieb_fg,
 zeit_stunde_bis,
 sw_rot_bis,
 sw_gelb_bis,
 sw_gelb_ab,
 sw_rot_ab
FROM kfl_production_dbp_data.sb_schwellwert_zeit_2;