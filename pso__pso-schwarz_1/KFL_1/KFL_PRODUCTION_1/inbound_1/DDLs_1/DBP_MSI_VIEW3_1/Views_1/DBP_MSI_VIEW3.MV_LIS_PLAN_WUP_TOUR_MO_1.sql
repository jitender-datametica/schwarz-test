CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIS_PLAN_WUP_TOUR_MO_1
(
-- Die auf VZ / Monatsebene / Tourebene vorliegenden Planzahlen werden auf Wochen pro Monat_1 / Tourebene dupliziert.
-- Der Bericht stellt Wochen pro ausgewählten Monat_1 dar.
mandant_id
,wup_id
,nb_id
,kjmo
,kjwo
,belos_tourart_id
,belos_tourstatus_id
,distribution_abr_fg
,plan_anzahl_touren
,plan_auslastung_volumen
,plan_transp_mengen_stell
,plan_auslastung_touren
,plan_frachtkosten
--,plan_auslastung
,plan_mp_komm
,plan_mp_kolli_komm
)
AS
   SELECT
   t01.mandant_id, t01.wup_id, t01.nb_id, t01.kjmo, t02.kjwo, belos_tourart_id_, belos_tourstatus_id, distribution_abr_fg, plan_anzahl_touren, plan_auslastung_volumen, plan_transp_mengen_stell, plan_auslastung_touren, plan_frachtkosten, plan_mp_komm, plan_mp_kolli_komm

   FROM (
   SELECT
   t01. mandant_id, t01.wup_id, t01.nb_id, t01.kjmo, CASE WHEN  lis_plan_typ_id =1 THEN 1 ELSE  t01.belos_tourart_id END AS belos_tourart_id_, MAX(99) AS belos_tourstatus_id, MAX(1) AS distribution_abr_fg, MAX(CASE WHEN lis_planzahl_id = 1 AND lis_plan_typ_id =2 THEN lis_plan_wert END) AS plan_anzahl_touren, NULL AS plan_auslastung_volumen, MAX(CASE WHEN lis_planzahl_id = 2 AND lis_plan_typ_id =2 THEN lis_plan_wert END) AS plan_transp_mengen_stell, MAX(CASE WHEN lis_planzahl_id = 3 AND lis_plan_typ_id =2 THEN lis_plan_wert END) AS plan_auslastung_touren, MAX(CASE WHEN lis_planzahl_id = 4 AND lis_plan_typ_id =2 THEN lis_plan_wert END) AS plan_frachtkosten, MAX(CASE WHEN lis_planzahl_id = 11 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_mp_komm, MAX(CASE WHEN lis_planzahl_id = 12 AND lis_plan_typ_id =1 THEN lis_plan_wert END) AS plan_mp_kolli_komm

   FROM dbp_view.v_lis_plan_wup_tour_mo_1 t01
   WHERE  lis_plan_typ_id IN (1,2)
   GROUP BY  t01.mandant_id
   ,t01.wup_id
   ,t01.nb_id
   ,t01.kjmo
   ,belos_tourart_id_
   ) t01
   INNER JOIN (SELECT kjmo,
   kjwo
   FROM dbp_msi_view3.mv_tag_1
   GROUP BY 1,2
   ) t02
   ON t01.kjmo = t02.kjmo;