CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_kumulation_gjwo_1 AS SELECT W1.gjwo AS gjwo_kum,
 W2.gjwo
FROM kfl_production_dbp_view.v_woche_1 AS W1
 INNER JOIN kfl_production_dbp_view.v_woche_1 AS W2 ON TRUNC(CAST(W1.gjwo / 100 AS BIGNUMERIC)) = TRUNC(CAST(W2.gjwo / 100 AS BIGNUMERIC)
    ) AND W1.gjwo <= W2.gjwo;