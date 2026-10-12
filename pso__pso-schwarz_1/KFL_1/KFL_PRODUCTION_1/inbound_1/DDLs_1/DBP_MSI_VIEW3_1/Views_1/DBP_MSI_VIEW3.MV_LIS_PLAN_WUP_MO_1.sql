CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIS_PLAN_WUP_MO_1
(
-- Die auf VZ / Monatsebene vorliegenden Planzahlen werden auf Wochen pro Monat_1 dupliziert.
-- Der Bericht stellt Wochen pro ausgewählten Monat_1 dar.
mandant_id
,wup_id
,nb_id
,kjmo
,kjwo
,belos_tourart_id
,belos_tourstatus_id
,distribution_abr_fg
,sonderabwicklung_id
,rundlauf_transport_fg
,plan_anz_belief_filiale
,plan_anteil_ungekuehlt
,plan_anlief_filiale_liefertag
,plan_anteil_oneway
,plan_anz_stopp_tour
,plan_transp_mengen_kolli
,plan_auslastung_touren_gesamt
,plan_stellplaetze_filiale_tag
,plan_stellplaetze_stopp
,plan_mp_faktor
,plan_mp_komm
,plan_mp_kolli_komm
)
AS
   SELECT
   t01. mandant_id, t01.wup_id, t01.nb_id, t01.kjmo, t02.kjwo, belos_tourart_id, belos_tourstatus_id, distribution_abr_fg, sonderabwicklung_id, rundlauf_transport_fg, plan_anz_belief_filiale, plan_anteil_ungekuehlt, plan_anlief_filiale_liefertag, plan_anteil_oneway, plan_anz_stopp_tour, plan_transp_mengen_kolli, plan_auslastung_touren_gesamt, plan_stellplaetze_filiale_tag, plan_stellplaetze_stopp, plan_mp_faktor, plan_mp_komm, plan_mp_kolli_komm
   FROM (
   SELECT
   mandant_id, wup_id, nb_id, kjmo, 1 AS belos_tourart_id  -- wird fest auf 1 gesetzt, da diese Kennzahlen für Filialebene relevant sind
   , MAX(99) AS belos_tourstatus_id -- wird fest auf 99 gesetzt, da Berichtsfilter auf >1 steht
   , MAX(1) AS distribution_abr_fg  -- wird fest auf 1 gesetzt, da Berichtsfilter auf =1 steht
   , MAX('UGK') AS sonderabwicklung_id -- -- wird fest auf UGK (ungekühlt) gesetzt, da Berichtsfilter auf = UGK steht
   , MAX(0) rundlauf_transport_fg -- wird fest auf 0 (OneWay) gesetzt, da Berichtsfilter auf = 0 steht
   , MAX(CASE WHEN lis_planzahl_id = 1 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_anz_belief_filiale, MAX(CASE WHEN lis_planzahl_id = 2 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_anteil_ungekuehlt, MAX(CASE WHEN lis_planzahl_id = 3 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_anlief_filiale_liefertag, MAX(CASE WHEN lis_planzahl_id = 4 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_anteil_oneway, MAX(CASE WHEN lis_planzahl_id = 5 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_anz_stopp_tour, MAX(CASE WHEN lis_planzahl_id = 6 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_transp_mengen_kolli, MAX(CASE WHEN lis_planzahl_id = 7 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_auslastung_touren_gesamt, MAX(CASE WHEN lis_planzahl_id = 8 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_stellplaetze_filiale_tag, MAX(CASE WHEN lis_planzahl_id = 9 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_stellplaetze_stopp, MAX(CASE WHEN lis_planzahl_id = 10 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_mp_faktor, MAX(CASE WHEN lis_planzahl_id = 11 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_mp_komm, MAX(CASE WHEN lis_planzahl_id = 12 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_mp_kolli_komm
   FROM dbp_view.v_lis_plan_wup_tour_mo_1 t01
   WHERE  lis_plan_typ_id =1
   GROUP BY t01. mandant_id
   ,t01.wup_id
   ,t01.nb_id
   ,t01.kjmo
   ,belos_tourart_id
   ) t01
   INNER JOIN (SELECT kjmo,
   kjwo
   FROM dbp_msi_view3.mv_tag_1
   GROUP BY 1,2
   ) t02
   ON t01.kjmo = t02.kjmo;