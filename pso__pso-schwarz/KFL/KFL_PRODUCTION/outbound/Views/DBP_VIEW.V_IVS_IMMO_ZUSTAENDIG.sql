CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_immo_zustaendig AS SELECT mandant_id,
 zustaendig_id,
 vorname,
 nachname,
 anrede
FROM kfl_production_dbp_data.ivs_immo_zustaendig;