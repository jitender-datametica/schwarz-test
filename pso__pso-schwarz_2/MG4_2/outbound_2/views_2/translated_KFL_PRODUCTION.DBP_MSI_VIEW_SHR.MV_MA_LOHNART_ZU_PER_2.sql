CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_lohnart_zu_per_2 (mandant_id, mitarbeiter_id, kjmo, system_id
, lohnart_id, kostenstelle_id, stunden_lohnart_7722, stunden_lohnart_7712, stunden_lohnart_7723,
stunden_lohnart_2702_plus, stunden_lohnart_2702_minus, stunden_lohnart_7705, stunden_lohnart_7514, stunden_lohnart_7515
, stunden_lohnart_7516, stunden_lohnart_7518, stunden_lohnart_7517, stunden_lohnart_7713, stunden_lohnart_7752,
stunden_lohnart_2704, stunden_lohnart_mvst, stunden_lohnart_7726) AS SELECT v01.mandant_id,
 v01.mitarbeiter_id,
 v01.kjmo,
 v01.system_id,
 v01.lohnart_id,
  CASE
  WHEN v01.lohnart_id = '2704'
  THEN v01.kostenstelle_id
  ELSE v02.kostenstelle_id
  END AS kostenstelle_id,
  CASE
  WHEN v01.lohnart_id = '7722'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7722,
  CASE
  WHEN v01.lohnart_id = '7712' AND (v01.mandant_id = 1 AND v03.mitarbeiter_kreis_id = '30' OR v01.mandant_id = 3 AND v03
       .mitarbeiter_kreis_id IN ('09', '17', '18', '19'))
  THEN TRUNC(CAST(v01.stunden_lohnart / 2 AS BIGNUMERIC))
  WHEN v01.lohnart_id = '7712'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7712,
  CASE
  WHEN v01.lohnart_id = '7723' AND (v01.mandant_id = 1 AND v03.mitarbeiter_kreis_id = '30' OR v01.mandant_id = 3 AND v03
       .mitarbeiter_kreis_id IN ('09', '17', '18', '19'))
  THEN TRUNC(CAST(v01.stunden_lohnart / 2 AS BIGNUMERIC))
  WHEN v01.lohnart_id = '7723'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7723,
  CASE
  WHEN v01.lohnart_id = '2702' AND v01.stunden_lohnart > 0
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_2702_plus,
  CASE
  WHEN v01.lohnart_id = '2702' AND v01.stunden_lohnart < 0
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_2702_minus,
  CASE
  WHEN v01.lohnart_id = '7705'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7705,
  CASE
  WHEN v01.lohnart_id = '7514'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7514,
  CASE
  WHEN v01.lohnart_id = '7515'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7515,
  CASE
  WHEN v01.lohnart_id = '7516'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7516,
  CASE
  WHEN v01.lohnart_id = '7518'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7518,
  CASE
  WHEN v01.lohnart_id = '7517'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7517,
  CASE
  WHEN v01.lohnart_id = '7713'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7713,
  CASE
  WHEN v01.lohnart_id = '7752'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7752,
  CASE
  WHEN v01.lohnart_id = '2704'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_2704,
  CASE
  WHEN v01.lohnart_id = 'MVST'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_mvst,
  CASE
  WHEN v01.lohnart_id = '7726'
  THEN v01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7726
FROM kfl_production_dbp_view.v_ma_lohnart_zu_per_2 AS v01
 LEFT JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_2 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.mitarbeiter_id
     = v02.mitarbeiter_id AND v01.kjmo = v02.kjmo
 LEFT JOIN kfl_production_dbp_view.v_ma_kreis_zu_per_2 AS v03 ON v01.mandant_id = v03.mandant_id AND v01.mitarbeiter_id =
    v03.mitarbeiter_id AND v01.kjmo = v03.kjmo;