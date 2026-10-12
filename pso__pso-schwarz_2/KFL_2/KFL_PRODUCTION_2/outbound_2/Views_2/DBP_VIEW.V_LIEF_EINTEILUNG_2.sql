CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lief_einteilung_2 AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 einteil_id,
 menge_einteil,
 dat_lief_wunsch,
 dat_lief_bewertung,
 mahnung_anz,
 system_id,
 flw_fg,
 td_insert,
 td_update
FROM kfl_production_dbp_data.lief_einteilung_2;