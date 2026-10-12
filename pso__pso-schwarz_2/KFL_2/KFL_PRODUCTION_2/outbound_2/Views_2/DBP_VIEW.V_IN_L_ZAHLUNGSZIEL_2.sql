CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_zahlungsziel_2 AS SELECT mandant_id,
 zahlungsziel_id,
 zahlungsziel_1_tage,
 zahlungsziel_1_prozent,
 zahlungsziel_2_tage,
 zahlungsziel_2_prozent,
 zahlungsziel_3_tage,
 zahlungsziel_max_tage,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_zahlungsziel_2;