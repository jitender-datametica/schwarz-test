CREATE OR REPLACE VIEW dbp_data_center.tv_artbew_12mo_avg_sum_2
AS
-- 21.10.2016 AP0010540: MIttelwertbildung: Summe(12 Monate) / Anzahl Monate mit Absatz
SELECT
mandant_id,
art_id,
wup_id,
menge1,
umsatz_netto1,
anz_mo
FROM
(SELECT
t1.mandant_id,
t2.kl_art_id AS art_id,
t1.wup_id AS wup_id,
SUM(menge)/COUNT(DISTINCT t1.kjmo)  AS menge1,
SUM(umsatz_netto)/COUNT(DISTINCT t1.kjmo)  AS umsatz_netto1,
COUNT(DISTINCT t1.kjmo) anz_mo
FROM dbp_view.v_artbew_mo_sum_2 t1_2
INNER JOIN dbp_view.v_art_2 t2
ON t1.art_id = t2.art_id
AND t1.mandant_id = t2.mandant_id
AND t2.dat_von <= CURRENT_DATE
AND t2.dat_bis = to_date('9999-12-31', 'YYYY-MM_2-DD')
AND t1.bewart_id <> 1002
INNER JOIN dbp_view.v_monat_2 t3
ON t1.kjmo = t3.kjmo
WHERE t3.akt_mo BETWEEN -12 AND -1
GROUP BY 1,2,3
) t1_2;