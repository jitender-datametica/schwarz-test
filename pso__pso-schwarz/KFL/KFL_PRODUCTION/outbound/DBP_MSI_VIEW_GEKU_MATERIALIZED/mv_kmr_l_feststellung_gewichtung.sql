-- 20221117 twie: SPEC0166860 neue audimex View für Gewichtung Feststellung

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_feststellung_gewichtung (feststellung_gewichtung_id
, amx_system_id, feststellung_gewichtung_bez) AS SELECT feststellung_gewichtung_id,
 amx_system_id,
 feststellung_gewichtung_bez
FROM dbp_view.v_kmr_l_feststellung_gewichtung;