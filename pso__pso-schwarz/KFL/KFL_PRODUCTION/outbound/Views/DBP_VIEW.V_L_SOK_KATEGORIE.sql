CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sok_kategorie AS SELECT mandant_id,
 sok_kategorie_id,
 sok_fima_baustein_id
FROM kfl_production_dbp_data.l_sok_kategorie;