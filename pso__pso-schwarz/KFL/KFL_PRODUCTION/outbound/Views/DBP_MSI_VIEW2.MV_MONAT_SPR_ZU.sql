CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_monat_spr_zu (mo_gj, mo_kj, spr_id, mo_bez, kjmo, kj, gj, gjmo,
mo_bez_lang) AS SELECT M.mo_gj,
 S.mo_id AS mo_kj,
 S.spr_id,
 S.mo_bez,
 M.kjmo,
 M.kj,
 M.gj,
 M.gjmo,
   TRIM(S.mo_bez) || ' ' || TRIM(SUBSTR(CAST(M.kj AS STRING), 1, 39)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu AS S
 INNER JOIN kfl_production_dbp_view.v_monat AS M ON S.mo_id = M.mo_kj
WHERE S.spr_id = 22;