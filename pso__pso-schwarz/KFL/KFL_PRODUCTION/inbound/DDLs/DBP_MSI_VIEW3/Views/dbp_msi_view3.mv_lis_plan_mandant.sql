CREATE OR REPLACE VIEW dbp_msi_view3.mv_lis_plan_mandant
(
-- Die auf VZ / Monatsebene vorliegenden Planzahlen werden auf Wochen pro Monat dupliziert.
-- Der Bericht stellt Wochen pro ausgewählten Monat dar.
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
,plan_anstosspauschale
)
AS
SELECT
t01. mandant_id
,t03.wup_id
,t03.nb_id
,t01.kjmo
,t02.kjwo
,belos_tourart_id
,belos_tourstatus_id
,distribution_abr_fg
,sonderabwicklung_id
,rundlauf_transport_fg
,plan_anstosspauschale
FROM (
SELECT
mandant_id
,wup_id
,nb_id
,t02.kjmo
,1 AS belos_tourart_id  -- wird fest auf 1 gesetzt, da diese Kennzahlen für Filialebene relevant sind
,MAX(99) AS belos_tourstatus_id -- wird fest auf 99 gesetzt, da Berichtsfilter auf >1 steht
,MAX(1) AS distribution_abr_fg  -- wird fest auf 1 gesetzt, da Berichtsfilter auf =1 steht
,MAX('UGK') AS sonderabwicklung_id -- -- wird fest auf UGK (ungekühlt) gesetzt, da Berichtsfilter auf = UGK steht
,MAX(0) rundlauf_transport_fg -- wird fest auf 0 (OneWay) gesetzt, da Berichtsfilter auf = 0 steht
,MAX(CASE WHEN lis_planzahl_id = 1 AND lis_plan_typ_id =3 THEN lis_plan_wert END) AS plan_anstosspauschale
FROM dbp_view.v_lis_plan_wup_tour_mo t01
CROSS JOIN dbp_msi_view3.mv_monat t02
WHERE  lis_plan_typ_id =3
AND gj >= 2009
GROUP BY t01. mandant_id
,t01.wup_id
,t01.nb_id
,t02.kjmo
,belos_tourart_id
) t01
INNER JOIN (SELECT kjmo,
kjwo
FROM dbp_msi_view3.mv_tag
GROUP BY 1,2
) t02
ON t01.kjmo = t02.kjmo


INNER JOIN (SELECT mandant_id
,wup_id
,nb_id
FROM dbp_msi_view3.mv_wup t02
WHERE nb_id = -111
) t03
ON t01.mandant_id = t03.mandant_id;