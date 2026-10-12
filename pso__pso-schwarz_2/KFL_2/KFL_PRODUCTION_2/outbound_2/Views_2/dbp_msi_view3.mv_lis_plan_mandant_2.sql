CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lis_plan_mandant_2 (mandant_id, wup_id, nb_id, kjmo, kjwo,
belos_tourart_id, belos_tourstatus_id, distribution_abr_fg, sonderabwicklung_id, rundlauf_transport_fg,
plan_anstosspauschale) AS SELECT t01.mandant_id,
 t03.wup_id,
 t03.nb_id,
 t01.kjmo,
 t02.kjwo,
 t01.belos_tourart_id,
 t01.belos_tourstatus_id,
 t01.distribution_abr_fg,
 t01.sonderabwicklung_id,
 t01.rundlauf_transport_fg,
 t01.plan_anstosspauschale
FROM (SELECT T01.mandant_id,
   T01.wup_id,
   T01.nb_id,
   T02.kjmo,
   1 AS belos_tourart_id,
   MAX(99) AS belos_tourstatus_id,
   MAX(1) AS distribution_abr_fg,
   MAX('UGK') AS sonderabwicklung_id,
   MAX(0) AS rundlauf_transport_fg,
   MAX(CASE
     WHEN T01.lis_planzahl_id = 1 AND T01.lis_plan_typ_id = 3
     THEN T01.lis_plan_wert
     ELSE NULL
     END) AS plan_anstosspauschale
  FROM kfl_production_dbp_view.v_lis_plan_wup_tour_mo_2 AS T01
   INNER JOIN kfl_production_dbp_msi_view3.mv_monat_2 AS T02 ON TRUE
  WHERE T01.lis_plan_typ_id = 3
   AND T02.gj >= 2009
  GROUP BY T01.mandant_id,
   T01.wup_id,
   T01.nb_id,
   T02.kjmo,
   T01.belos_tourart_id) AS t01
 INNER JOIN (SELECT kjmo,
   kjwo
  FROM kfl_production_dbp_msi_view3.mv_tag_2
  GROUP BY kjmo,
   kjwo) AS t02 ON t01.kjmo = t02.kjmo
 INNER JOIN (SELECT mandant_id,
   wup_id,
   nb_id
  FROM kfl_production_dbp_msi_view3.mv_wup_2 AS T02
  WHERE nb_id = - 111) AS t03 ON t01.mandant_id = t03.mandant_id;