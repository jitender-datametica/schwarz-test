CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sm_food_helper_1 AS SELECT sm01.mandant_id,
 sm01.nb_id,
 sm01.wup_id,
 sm01.sm_id AS sst_food_id,
 sm02.sm_id,
 sm02.abt_id,
 sm02.wg_id,
  CASE
  WHEN sm02.wg_id IS NULL
  THEN '-'
  ELSE CAST(TRIM(TRIM(CAST(sm02.wg_id AS STRING FORMAT '000'))) AS STRING)
  END AS wg,
  CASE
  WHEN sm02.wg_id IS NULL
  THEN '-'
  ELSE 'WG' || CAST(TRIM(TRIM(CAST(sm02.wg_id AS STRING FORMAT '000'))) AS STRING)
  END AS wg_bez,
 RANK() OVER (PARTITION BY CAST(sm01.mandant_id AS STRING), CAST(sm01.wup_id AS STRING), CAST(sm01.sm_id AS STRING)
  ORDER BY sm01.mandant_id IS NULL, sm01.mandant_id, sm01.wup_id IS NULL, sm01.wup_id, sm01.sm_id IS NULL, sm01.sm_id,
    sm02.wg_id IS NULL, sm02.wg_id) AS wg_count
FROM (SELECT mandant_id,
   nb_id,
   wup_id,
   sm_id
  FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per_1
  WHERE dat_bis = DATE '9999-12-31'
   AND arthiertyp_id = 2
   AND nb_id = 0
   AND wg_id = 410
   AND sm_id >= 0
   AND mandant_id = 1) AS sm01
 LEFT JOIN (SELECT SM.mandant_id,
   SM.wup_id,
   SM.sm_id,
   SM.wg_id,
   WG.abt_id
  FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per_1 AS SM_1
   INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS WG ON SM.mandant_id = WG.mandant_id AND SM.wg_id = WG.wg_id
  WHERE SM.dat_bis = DATE '9999-12-31'
   AND SM.arthiertyp_id = 2
   AND SM.nb_id = 0
   AND SM.sm_id >= 0
   AND WG.dat_bis = DATE '9999-12-31'
   AND WG.arthiertyp_id = 2
   AND WG.abt_id IN (5, 6)
   AND SM.mandant_id = 1) AS sm02 ON sm01.mandant_id = sm02.mandant_id AND sm01.wup_id = sm02.wup_id AND sm01.sm_id <>
   sm02.sm_id;