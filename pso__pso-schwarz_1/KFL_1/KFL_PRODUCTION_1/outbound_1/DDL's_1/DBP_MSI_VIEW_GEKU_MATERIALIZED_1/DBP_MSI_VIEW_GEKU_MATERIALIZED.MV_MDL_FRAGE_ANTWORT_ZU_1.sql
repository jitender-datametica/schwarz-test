-- 12.10.2022 twie: SPEC0167837 sek_kz von 51 auf 1 geändert

-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

-- 11.12.2020 SPEC0087215, AP0066293, Pawel Staniszewski, adding sec_kz and nok_fg

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_mdl_frage_antwort_zu_1 (frage_id, antwort_id,
sec_kz, nok_fg) AS SELECT frage_id,
 antwort_id,
 1 AS sec_kz,
 nok_fg
FROM kfl_production_dbp_view.v_mdl_frage_antwort_zu_1 AS V01;