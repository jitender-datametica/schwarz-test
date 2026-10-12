CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 wg_verkett_id,
 wg_verkett_hier_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.wg_verkettung_hierarchie_zu_per_2;