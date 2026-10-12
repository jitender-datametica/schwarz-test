-- 20221117 twie: SPEC0166860 neue audimex View für Feststellung

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_feststellung (amx_system_id, feststellung_id,
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
FROM kfl_production_dbp_view.v_kmr_feststellung;