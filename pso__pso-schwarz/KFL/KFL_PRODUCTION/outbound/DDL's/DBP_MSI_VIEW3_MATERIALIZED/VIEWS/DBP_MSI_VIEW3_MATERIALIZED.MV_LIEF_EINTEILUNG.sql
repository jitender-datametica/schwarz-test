CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_lief_einteilung (best_beleg_id, best_beleg_pos_id,
dat_lief_bewertung, dat_lief_wunsch, einteil_id, mahnung_anz, mandant_id, menge_einteil) AS SELECT best_beleg_id,
 best_beleg_pos_id,
 dat_lief_bewertung,
 dat_lief_wunsch,
 einteil_id,
 mahnung_anz,
 mandant_id,
 menge_einteil
FROM kfl_production_dbp_view.v_lief_einteilung;