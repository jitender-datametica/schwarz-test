CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_bonuskauf (mandant_id, bonuskauf_id,
bonuskauf_bez, zeit_von, zeit_bis, konditionsart_id, geschaeftsvorfall_id, dat_von, dat_bis, aktion_id, spr_id) AS
SELECT V01.mandant_id,
 V01.bonuskauf_id,
 V03.bonuskauf_bez,
 V01.zeit_von,
 V01.zeit_bis,
 V01.konditionsart_id,
 V01.geschaeftsvorfall_id,
 V01.dat_von,
 V01.dat_bis,
 V01.aktion_id,
 V03.spr_id
FROM kfl_production_dbp_view.v_l_bonuskauf AS V01
 INNER JOIN kfl_production_dbp_view.v_bonuskauf_spr_zu AS V03 ON V01.bonuskauf_id = V03.bonuskauf_id AND V01.mandant_id
   = V03.mandant_id;