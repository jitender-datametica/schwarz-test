CREATE OR REPLACE VIEW dbp_data_center.tv_artbew_mo_sum_1 AS
SELECT mandant_id
,art_id
,wup_id
,kjmo
,menge1
,umsatz_netto1
FROM
(
SELECT t1.mandant_id
,t2.kl_art_id AS art_id
,t1.wup_id
,t1.kjmo
,SUM(menge) AS menge1
,SUM(umsatz_netto) AS umsatz_netto1

FROM dbp_view.v_artbew_mo_sum_1 t1_1
INNER JOIN dbp_view.v_art_1 t2
ON t1.art_id = t2.art_id
AND t1.mandant_id = t2.mandant_id
AND t2.dat_von <= CURRENT_DATE
AND t2.dat_bis = '9999-12-31'
AND t1.bewart_id <> 1002
GROUP BY 1,2,3,4
) t1_1;