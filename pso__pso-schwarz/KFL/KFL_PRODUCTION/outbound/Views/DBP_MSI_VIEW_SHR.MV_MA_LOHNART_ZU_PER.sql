CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_lohnart_zu_per (mandant_id, mitarbeiter_id, kjmo, system_id
, lohnart_id, kostenstelle_id, stunden_lohnart_7722, stunden_lohnart_7712, stunden_lohnart_7723,
stunden_lohnart_2702_plus, stunden_lohnart_2702_minus, stunden_lohnart_7705, stunden_lohnart_7514, stunden_lohnart_7515
, stunden_lohnart_7516, stunden_lohnart_7518, stunden_lohnart_7517, stunden_lohnart_7713, stunden_lohnart_7752,
stunden_lohnart_2704, stunden_lohnart_mvst, stunden_lohnart_7726) AS SELECT V01.mandant_id,
 V01.mitarbeiter_id,
 V01.kjmo,
 V01.system_id,
 V01.lohnart_id,
  CASE
  WHEN V01.lohnart_id = '2704'
  THEN V01.kostenstelle_id
  ELSE V02.kostenstelle_id
  END AS kostenstelle_id,
  CASE
  WHEN V01.lohnart_id = '7722'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7722,
  CASE
  WHEN V01.lohnart_id = '7712' AND (V01.mandant_id = 1 AND V03.mitarbeiter_kreis_id = '30' OR V01.mandant_id = 3 AND V03
       .mitarbeiter_kreis_id IN ('09', '17', '18', '19'))
  THEN TRUNC(CAST(V01.stunden_lohnart / 2 AS BIGNUMERIC))
  WHEN V01.lohnart_id = '7712'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7712,
  CASE
  WHEN V01.lohnart_id = '7723' AND (V01.mandant_id = 1 AND V03.mitarbeiter_kreis_id = '30' OR V01.mandant_id = 3 AND V03
       .mitarbeiter_kreis_id IN ('09', '17', '18', '19'))
  THEN TRUNC(CAST(V01.stunden_lohnart / 2 AS BIGNUMERIC))
  WHEN V01.lohnart_id = '7723'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7723,
  CASE
  WHEN V01.lohnart_id = '2702' AND V01.stunden_lohnart > 0
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_2702_plus,
  CASE
  WHEN V01.lohnart_id = '2702' AND V01.stunden_lohnart < 0
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_2702_minus,
  CASE
  WHEN V01.lohnart_id = '7705'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7705,
  CASE
  WHEN V01.lohnart_id = '7514'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7514,
  CASE
  WHEN V01.lohnart_id = '7515'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7515,
  CASE
  WHEN V01.lohnart_id = '7516'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7516,
  CASE
  WHEN V01.lohnart_id = '7518'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7518,
  CASE
  WHEN V01.lohnart_id = '7517'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7517,
  CASE
  WHEN V01.lohnart_id = '7713'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7713,
  CASE
  WHEN V01.lohnart_id = '7752'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7752,
  CASE
  WHEN V01.lohnart_id = '2704'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_2704,
  CASE
  WHEN V01.lohnart_id = 'MVST'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_mvst,
  CASE
  WHEN V01.lohnart_id = '7726'
  THEN V01.stunden_lohnart
  ELSE NULL
  END AS stunden_lohnart_7726
FROM kfl_production_dbp_view.v_ma_lohnart_zu_per AS V01
 LEFT JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per AS V02 ON V01.mandant_id = V02.mandant_id AND V01.mitarbeiter_id
     = V02.mitarbeiter_id AND V01.kjmo = V02.kjmo
 LEFT JOIN kfl_production_dbp_view.v_ma_kreis_zu_per AS V03 ON V01.mandant_id = V03.mandant_id AND V01.mitarbeiter_id =
    V03.mitarbeiter_id AND V01.kjmo = V03.kjmo;