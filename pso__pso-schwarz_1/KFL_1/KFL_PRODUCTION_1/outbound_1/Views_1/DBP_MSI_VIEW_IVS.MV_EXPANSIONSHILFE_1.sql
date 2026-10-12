CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_expansionshilfe_1 (gj, gj_vj, krk_id, mandant_id, kj, ker_mo_id
, startdate, akt_gj) AS SELECT M.gj,
  M.gj - 1 AS gj_vj,
 M.krk_id,
 M.mandant_id,
 M.kj,
 M.ker_mo_id,
    TRIM(SUBSTR(CAST(M.gj - 1 AS STRING), 1, 39)) || '-0' || TRIM(SUBSTR(CAST(M.ker_mo_id AS STRING), 1, 39)) || '-01'
 AS startdate,
 J.akt_gj
FROM kfl_production_dbp_view.v_ker_mo_periode_zu_1 AS M
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_jahr_gj_1 AS J ON M.gj = J.gj
WHERE M.buchungsperiode_id = 1
 AND J.akt_gj = 0;