CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_zahlungsziel (mandant_id, zahlungsziel_id,
zahlungsziel_1_tage, zahlungsziel_1_prozent) AS SELECT mandant_id,
 zahlungsziel_id,
 zahlungsziel_1_tage,
 zahlungsziel_1_prozent
FROM kfl_production_dbp_view.v_l_zahlungsziel AS V01
WHERE mandant_id <> 1;