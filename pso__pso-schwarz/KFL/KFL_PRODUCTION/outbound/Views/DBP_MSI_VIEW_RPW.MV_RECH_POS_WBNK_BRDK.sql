CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_rech_pos_wbnk_brdk (system_id, mandant_id, rech_beleg_id, gj,
wbnk_planungs_kz, row_grund_id) AS SELECT 7 AS system_id,
 BR.mandant_id,
 BR.rech_beleg_id,
 BR.gj,
  CASE
  WHEN BRDK.row_grund_id IN ('117', '124', '125', '126', '129', '133', '135')
  THEN 'statistisch geplant'
  WHEN BRDK.row_grund_id IN ('113', '127', '128', '131', '136', '143', '162')
  THEN 'ungeplant'
  WHEN BRDK.row_grund_id IN ('146', '150', '152', '154', '163', '165', '174')
  THEN 'sonstige Erlöse'
  WHEN BRDK.row_grund_id IN ('118', '130', '137', '141', '144', '145', '147', '151', '153', '164', '172', '173', '175')
  THEN 'Sachkosten'
  ELSE 'keine BNK'
  END AS wbnk_planungs_kz,
 COALESCE(BRDK.row_grund_id, '0') AS row_grund_id
FROM kfl_production_dbp_view.v_besch_rech AS BR
 LEFT JOIN kfl_production_dbp_view.v_besch_rech_det_kont AS BRDK ON BR.mandant_id = BRDK.mandant_id AND BR.rech_beleg_id
     = BRDK.rech_beleg_id AND BR.gj = BRDK.gj
WHERE BR.mandant_id = 1
GROUP BY system_id,
 BR.mandant_id,
 BR.rech_beleg_id,
 BR.gj,
 row_grund_id,
 wbnk_planungs_kz;