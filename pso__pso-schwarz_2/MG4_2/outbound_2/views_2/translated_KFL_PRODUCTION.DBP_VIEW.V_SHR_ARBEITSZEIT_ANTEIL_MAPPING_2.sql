CREATE OR REPLACE VIEW kfl_production_dbp_view.v_shr_arbeitszeit_anteil_mapping_2 (mandant_id, kjmo_bis, anz_stunden_bis,
kjmo_von, anz_stunden_von, arbeitszeit_anteil) AS SELECT mandant_id,
 kjmo_bis,
 anz_stunden_bis,
 kjmo_von,
 anz_stunden_von,
 arbeitszeit_anteil
FROM kfl_production_dbp_data.shr_arbeitszeit_anteil_mapping_2;