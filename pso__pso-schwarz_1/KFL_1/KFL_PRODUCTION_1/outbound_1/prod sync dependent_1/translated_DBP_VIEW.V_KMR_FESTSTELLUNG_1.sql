CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_feststellung_1 (amx_system_id, feststellung_id, frage_id,
feststellung_bez, feststellung_text, feststellung_gewichtung_id, compliance_fg, berichtsrelevant_fg, effizienz_fg,
wiederkehrend_fg) AS SELECT amx_system_id,
 feststellung_id,
 frage_id,
 feststellung_bez,
 feststellung_text,
 feststellung_gewichtung_id,
 compliance_fg,
 berichtsrelevant_fg,
 effizienz_fg,
 wiederkehrend_fg
FROM kfl_production_dbp_data.kmr_feststellung_1;