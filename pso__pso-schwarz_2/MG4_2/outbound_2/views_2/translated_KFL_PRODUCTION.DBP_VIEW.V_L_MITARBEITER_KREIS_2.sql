CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_mitarbeiter_kreis_2 (mandant_id, mitarbeiter_kreis_id) AS SELECT
 mandant_id,
 mitarbeiter_kreis_id
FROM kfl_production_dbp_data.l_mitarbeiter_kreis_2;