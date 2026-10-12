CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_qual_ursache_1 AS SELECT mandant_id,
 qual_meldung_id,
 qual_meldung_pos_id,
 qual_meldung_ursache_id,
 katalogart_id,
 codegruppe_id,
 pruefcode_id,
 version_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_qual_ursache_1;