-- 20221116 twie: SPEC0166860 neue audimex View für Fragetyp

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_frage_typ_2 (frage_typ_id, amx_system_id, frage_typ_bez) AS
SELECT frage_typ_id,
 amx_system_id,
 frage_typ_bez
FROM kfl_production_dbp_view.v_kmr_l_frage_typ_2;