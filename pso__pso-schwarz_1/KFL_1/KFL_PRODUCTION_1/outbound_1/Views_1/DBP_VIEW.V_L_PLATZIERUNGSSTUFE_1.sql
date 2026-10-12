CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_platzierungsstufe_1 AS SELECT mandant_id,
 platzierungsstufe_id,
 sk_id_apollo,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_platzierungsstufe_1;