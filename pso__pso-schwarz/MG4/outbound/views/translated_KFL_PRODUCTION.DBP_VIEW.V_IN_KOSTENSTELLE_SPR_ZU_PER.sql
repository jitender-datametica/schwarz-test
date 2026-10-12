CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per (mandant_id, kostenstelle_id, krk_id,
dat_von, spr_id, dat_bis, kostenstelle_bez, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.in_kostenstelle_spr_zu_per;