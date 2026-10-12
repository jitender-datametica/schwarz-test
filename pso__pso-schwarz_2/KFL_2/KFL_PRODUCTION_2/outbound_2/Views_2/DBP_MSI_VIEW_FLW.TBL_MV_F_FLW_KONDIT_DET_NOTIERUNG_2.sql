----# neu mv_f_kondit_det_


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_kondit_det_notierung_2 AS SELECT V01.mandant_id,
 V01.werk_id,
 V01.flw_lief_id,
 V01.flw_art_id,
 V01.loesch_fg,
 V02.konditionsart_id,
 V02.dat_von,
 T.dat,
 V02.kondition_id,
 V100.default_wrg,
 V03.kondition_einh_id,
 V03.betrag_kondition,
  CASE
  WHEN V01.flw_art_id IN (74460, 238620, 2531, 2537, 2541, 2553, 2555, 2557, 2561, 2563, 2572, 2577, 2840, 2755, 2689,
    2682, 2684)
  THEN 1
  WHEN V01.flw_art_id IN (74462, 238621, 74462, 3385, 3317, 45314, 234036, 234046, 3382, 3360, 43015, 206934, 3401, 3326
    , 3368, 3993, 4039)
  THEN 2
  WHEN V01.flw_art_id IN (238627, 238633)
  THEN 3
  WHEN V01.flw_art_id IN (237492, 237492, 233472, 233487, 235772, 235782, 233482, 235770, 235780, 233478)
  THEN 4
  WHEN V01.flw_art_id IN (2840, 2755, 2689, 2682, 2684)
  THEN 5
  ELSE 6
  END AS fleisch_kategorie_id,
  CASE
  WHEN V01.flw_art_id IN (74460, 74462, 238627, 238633, 237492)
  THEN 1
  WHEN V01.flw_art_id IN (238620, 238621)
  THEN 2
  ELSE 3
  END AS kpi_kategorie_id
FROM kfl_production_dbp_view.v_flw_art_gp_wup_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_gp_kondit_wup_zu_per_2 AS V02 ON V01.werk_id = V02.werk_id AND V01.flw_lief_id
      = V02.flw_lief_id AND V01.flw_art_id = V02.flw_art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_kondit_det_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.kondition_id =
    V03.kondition_id AND V02.konditionsart_id = V03.konditionsart_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON T.dat BETWEEN V02.dat_von AND V02.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id;