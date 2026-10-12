CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lis_plan_wup_tour_mo (mandant_id, wup_id, nb_id, kjmo, kjwo,
belos_tourart_id, belos_tourstatus_id, distribution_abr_fg, plan_anzahl_touren, plan_auslastung_volumen,
plan_transp_mengen_stell, plan_auslastung_touren, plan_frachtkosten, plan_mp_komm, plan_mp_kolli_komm) AS SELECT t01.mandant_id
 ,
 t01.wup_id,
 t01.nb_id,
 t01.kjmo,
 t02.kjwo,
 t01.belos_tourart_id_ AS belos_tourart_id,
 t01.belos_tourstatus_id,
 t01.distribution_abr_fg,
 t01.plan_anzahl_touren,
 t01.plan_auslastung_volumen,
 t01.plan_transp_mengen_stell,
 t01.plan_auslastung_touren,
 t01.plan_frachtkosten,
 t01.plan_mp_komm,
 t01.plan_mp_kolli_komm
FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   kjmo,
    CASE
    WHEN lis_plan_typ_id = 1
    THEN 1
    ELSE belos_tourart_id
    END AS belos_tourart_id_,
   MAX(99) AS belos_tourstatus_id,
   MAX(1) AS distribution_abr_fg,
   MAX(CASE
     WHEN lis_planzahl_id = 1 AND lis_plan_typ_id = 2
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_anzahl_touren,
   NULL AS plan_auslastung_volumen,
   MAX(CASE
     WHEN lis_planzahl_id = 2 AND lis_plan_typ_id = 2
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_transp_mengen_stell,
   MAX(CASE
     WHEN lis_planzahl_id = 3 AND lis_plan_typ_id = 2
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_auslastung_touren,
   MAX(CASE
     WHEN lis_planzahl_id = 4 AND lis_plan_typ_id = 2
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_frachtkosten,
   MAX(CASE
     WHEN lis_planzahl_id = 11 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_mp_komm,
   MAX(CASE
     WHEN lis_planzahl_id = 12 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_mp_kolli_komm
  FROM kfl_production_dbp_view.v_lis_plan_wup_tour_mo AS T01
  WHERE lis_plan_typ_id IN (1, 2)
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   kjmo,
   belos_tourart_id_) AS t01
 INNER JOIN (SELECT kjmo,
   kjwo
  FROM kfl_production_dbp_msi_view3.mv_tag
  GROUP BY kjmo,
   kjwo) AS t02 ON t01.kjmo = t02.kjmo;