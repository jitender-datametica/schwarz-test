CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_qual_meldung_det AS SELECT qual_meldung_id,
 qual_meldung_pos_id,
 mandant_id,
 katalogart_id,
 codegruppe_id,
 pruefcode_id,
 fehlgrund_id,
 fehlerklasse_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_qual_meldung_det;