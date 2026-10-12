CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sok_abteilung AS SELECT mandant_id,
 sok_abteilung_id,
 food_nonfood_kategorie_id
FROM kfl_production_dbp_data.l_sok_abteilung;