CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_bonuskauf (mandant_id, bonuskauf_id, zeit_von, zeit_bis
, konditionsart_id, geschaeftsvorfall_id, dat_von, dat_bis, aktion_id) AS SELECT mandant_id,
 bonuskauf_id,
 zeit_von,
 zeit_bis,
 konditionsart_id,
 geschaeftsvorfall_id,
 dat_von,
 dat_bis,
 aktion_id
FROM kfl_production_dbp_data.l_bonuskauf;