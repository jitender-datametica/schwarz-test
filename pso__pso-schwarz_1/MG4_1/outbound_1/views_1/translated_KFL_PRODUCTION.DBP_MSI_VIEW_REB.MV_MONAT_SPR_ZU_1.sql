CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_monat_spr_zu_1 (mo_gj, mo_kj, spr_id, mo_bez, kjmo, kj, gj, gjmo
, mo_bez_lang) AS SELECT v02.mo_gj,
 v01.mo_id AS mo_kj,
 v01.spr_id,
 v01.mo_bez,
 v02.kjmo,
 v02.kj,
 v02.gj,
 v02.gjmo,
   TRIM(v01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(v02.kj AS STRING), 1, 10)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS v02 ON v01.mo_id = v02.mo_kj
WHERE v01.spr_id = 22;