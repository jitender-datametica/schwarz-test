CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_energiedaten (mandant_id, zaehler_id, dat, kjmo, pc_id,
krk_id, menge_verbraucht) AS SELECT mandant_id,
 zaehler_id,
 dat,
 kjmo,
 pc_id,
 krk_id,
 menge_verbrauch AS menge_verbraucht
FROM kfl_production_dbp_view.v_flw_energiedaten AS V01;