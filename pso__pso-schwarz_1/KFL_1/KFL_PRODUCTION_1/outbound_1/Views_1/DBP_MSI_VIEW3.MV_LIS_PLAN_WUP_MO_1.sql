CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lis_plan_wup_mo_1 (mandant_id, wup_id, nb_id, kjmo, kjwo,
belos_tourart_id, belos_tourstatus_id, distribution_abr_fg, sonderabwicklung_id, rundlauf_transport_fg,
plan_anz_belief_filiale, plan_anteil_ungekuehlt, plan_anlief_filiale_liefertag, plan_anteil_oneway, plan_anz_stopp_tour
, plan_transp_mengen_kolli, plan_auslastung_touren_gesamt, plan_stellplaetze_filiale_tag, plan_stellplaetze_stopp,
plan_mp_faktor, plan_mp_komm, plan_mp_kolli_komm) AS SELECT t01.mandant_id,
 t01.wup_id,
 t01.nb_id,
 t01.kjmo,
 t02.kjwo,
 t01.belos_tourart_id,
 t01.belos_tourstatus_id,
 t01.distribution_abr_fg,
 t01.sonderabwicklung_id,
 t01.rundlauf_transport_fg,
 t01.plan_anz_belief_filiale,
 t01.plan_anteil_ungekuehlt,
 t01.plan_anlief_filiale_liefertag,
 t01.plan_anteil_oneway,
 t01.plan_anz_stopp_tour,
 t01.plan_transp_mengen_kolli,
 t01.plan_auslastung_touren_gesamt,
 t01.plan_stellplaetze_filiale_tag,
 t01.plan_stellplaetze_stopp,
 t01.plan_mp_faktor,
 t01.plan_mp_komm,
 t01.plan_mp_kolli_komm
FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   kjmo,
   1 AS belos_tourart_id,
   MAX(99) AS belos_tourstatus_id,
   MAX(1) AS distribution_abr_fg,
   MAX('UGK') AS sonderabwicklung_id,
   MAX(0) AS rundlauf_transport_fg,
   MAX(CASE
     WHEN lis_planzahl_id = 1 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_anz_belief_filiale,
   MAX(CASE
     WHEN lis_planzahl_id = 2 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_anteil_ungekuehlt,
   MAX(CASE
     WHEN lis_planzahl_id = 3 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_anlief_filiale_liefertag,
   MAX(CASE
     WHEN lis_planzahl_id = 4 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_anteil_oneway,
   MAX(CASE
     WHEN lis_planzahl_id = 5 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_anz_stopp_tour,
   MAX(CASE
     WHEN lis_planzahl_id = 6 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_transp_mengen_kolli,
   MAX(CASE
     WHEN lis_planzahl_id = 7 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_auslastung_touren_gesamt,
   MAX(CASE
     WHEN lis_planzahl_id = 8 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_stellplaetze_filiale_tag,
   MAX(CASE
     WHEN lis_planzahl_id = 9 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_stellplaetze_stopp,
   MAX(CASE
     WHEN lis_planzahl_id = 10 AND lis_plan_typ_id = 1
     THEN lis_plan_wert
     ELSE NULL
     END) AS plan_mp_faktor,
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
  FROM kfl_production_dbp_view.v_lis_plan_wup_tour_mo_1 AS T01
  WHERE lis_plan_typ_id = 1
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   kjmo,
   T01.belos_tourart_id) AS t01
 INNER JOIN (SELECT kjmo,
   kjwo
  FROM kfl_production_dbp_msi_view3.mv_tag_1
  GROUP BY kjmo,
   kjwo) AS t02 ON t01.kjmo = t02.kjmo;