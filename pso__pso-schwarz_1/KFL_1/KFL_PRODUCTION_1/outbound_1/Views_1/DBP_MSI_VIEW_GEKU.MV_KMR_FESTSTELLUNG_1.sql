CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_feststellung_1 (amx_system_id, feststellung_id,
feststellung_bez, feststellung_text, frage_id, feststellung_gewichtung_id, compliance_fg, berichtsrelevant_fg,
effizienz_fg, wiederkehrend_fg) AS SELECT amx_system_id,
 feststellung_id,
 feststellung_bez,
 feststellung_text,
 frage_id,
 feststellung_gewichtung_id,
 compliance_fg,
 berichtsrelevant_fg,
 effizienz_fg,
 wiederkehrend_fg
FROM kfl_production_dbp_view.v_kmr_feststellung_1;