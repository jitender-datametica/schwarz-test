CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belos_transportauftrag_aufwand_upload_2 AS SELECT mandant_id,
 belos_vorgang_id,
 transportauftrag_id,
 wrg_id,
 aufwand_vorlauf,
 aufwand_hauptlauf,
 aufwand_umschlag,
 aufwand_diesel,
 aufwand_gesamt
FROM kfl_production_dbp_data.belos_transportauftrag_aufwand_upload_2;