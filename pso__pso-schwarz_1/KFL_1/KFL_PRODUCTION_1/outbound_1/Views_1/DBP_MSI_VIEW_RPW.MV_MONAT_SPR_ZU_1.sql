CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_monat_spr_zu_1 (mo_gj, mo_kj, spr_id, mo_bez, kjmo, kj, gj, gjmo
, mo_bez_lang, system_id) AS SELECT MONAT.mo_gj,
 TEXT.mo_id AS mo_kj,
 TEXT.spr_id,
 TEXT.mo_bez,
 MONAT.kjmo,
 MONAT.kj,
 MONAT.gj,
 MONAT.gjmo,
   TRIM(TEXT.mo_bez) || ' ' || TRIM(SUBSTR(CAST(MONAT.kj AS STRING), 1, 39)) AS mo_bez_lang,
 7 AS system_id
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS TEXT
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS MONAT_1 ON TEXT.mo_id = MONAT.mo_kj AND TEXT.spr_id = 22 AND MONAT.kjmo >=
    200501 AND MONAT.kj <= EXTRACT(YEAR FROM CURRENT_DATE);