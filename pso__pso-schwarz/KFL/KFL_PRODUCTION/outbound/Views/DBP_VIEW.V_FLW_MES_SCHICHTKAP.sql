CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_schichtkap AS SELECT mandant_id,
 schicht_id,
 kapatyp_id,
 schichttyp_id,
 ngrad_angabe,
 kapa_dauer,
 kapa_einh,
 mengen_anz,
 dat_schicht,
 pause_dauer_sec
FROM kfl_production_dbp_data.flw_mes_schichtkap;