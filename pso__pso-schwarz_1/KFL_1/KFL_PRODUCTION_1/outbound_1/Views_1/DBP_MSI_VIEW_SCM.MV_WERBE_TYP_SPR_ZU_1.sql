CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_werbe_typ_spr_zu_1 AS SELECT WSZ.werbe_typ_id,
 MAX(WSZ.werbe_typ_bez) AS werbe_typ_bez,
 STRING_AGG(TRIM(M.mandant_kbez), ', ' ORDER BY M.mandant_id IS NULL, M.mandant_id) AS werbe_typ_mandanten,
      CAST(WSZ.werbe_typ_id AS STRING) || ': ' || MAX(WSZ.werbe_typ_bez) || ' (' || STRING_AGG(TRIM(M.mandant_kbez),
    ', ' ORDER BY M.mandant_id IS NULL, M.mandant_id) || ')' AS werbe_typ_bez_lang
FROM kfl_production_dbp_view.v_werbe_typ_spr_zu_1 AS WSZ
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS M ON WSZ.mandant_id = M.mandant_id
GROUP BY WSZ.werbe_typ_id;