CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wpl_ffaktor_1 AS SELECT mandant_id,
 platzierungsstufe_id,
 platzierungswg_id,
 faktor
FROM kfl_production_dbp_data.wpl_ffaktor_1;