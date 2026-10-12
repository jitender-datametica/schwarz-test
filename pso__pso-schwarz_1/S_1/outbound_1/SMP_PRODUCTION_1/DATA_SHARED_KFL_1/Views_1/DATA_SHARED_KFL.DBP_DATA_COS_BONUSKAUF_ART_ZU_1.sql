CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_cos_bonuskauf_art_zu_1 (mandant_id, bonuskauf_id, kl_art_id
, gratis_artikel_fg, td_update, td_insert) AS SELECT mandant_id,
 bonuskauf_id,
 kl_art_id,
 gratis_artikel_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cos_bonuskauf_art_zu_1;