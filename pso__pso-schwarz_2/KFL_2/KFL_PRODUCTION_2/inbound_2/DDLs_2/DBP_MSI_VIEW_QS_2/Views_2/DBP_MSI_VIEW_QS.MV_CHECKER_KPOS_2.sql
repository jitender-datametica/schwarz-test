CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_CHECKER_KPOS_2
-- 25.08.2016 - MCan: Initiale Anlage_2
-- 05.09.2016 - MCan: Anpassung bzgl. Businessday-Logik (dat_booking statt bon_dat)
AS
SELECT
t1.mandant_id
, t1.wup_id
, t1.dat_booking
, t2.umsatz_brutto_kassenabschluss
, t2.anz_kunden_kassenabschluss
, t2.anz_kunden_imbiss_kassenabschluss
, t3.bonanzahl
, t3.bonanzahl_imbiss
, SUM(t1.umsatz_brutto_verkauf) AS umsatz_brutto_all
, t2.umsatz_brutto_kassenabschluss - umsatz_brutto_all AS differenz
, differenz / NULLIFZERO(t2.umsatz_brutto_kassenabschluss) * 100 AS "%-Abw"
FROM
(
SELECT
k.mandant_id
, k.wup_id
, k.dat_booking
, SUM(v.umsatz_brutto) AS umsatz_brutto_verkauf
FROM dbp_v_ods.V_ods_bon_kopf_2 k
JOIN dbp_v_ods.V_ods_bon_verkauf_2 v
ON k.bon_id = v.bon_id
AND k.mandant_id = v.mandant_id
AND k.wup_id = v.wup_id
WHERE (k.mandant_id, k.wup_id, k.bon_id) NOT IN (SELECT mandant_id, wup_id, bon_id FROM dbp_v_ods.V_ods_bon_storno_2)
AND k.turnover_fg = 1
AND (k.mandant_id, k.wup_id, k.dat_booking) IN
(
SELECT
k.mandant_id
, k.wup_id
, k.dat_booking
FROM dbp_v_ods.V_bon_load_status_2 b
JOIN dbp_v_ods.V_ods_bon_transaction_2 k
ON k.datei_name = b.xml_name
WHERE k.kassensystem_name = 'KPOS'
/*AND CAST(b.IsFile_Time AS DATE) = DATE*/
/*AND k.bon_dat BETWEEN DATE-7 AND DATE-1*/
GROUP BY 1,2,3
)
GROUP BY 1,2,3

UNION

SELECT
k.mandant_id
, k.wup_id
, k.dat_booking
, SUM(v.umsatz_brutto) AS umsatz_brutto_verkauf
FROM dbp_v_ods.V_ods_bon_kopf_2 k
JOIN dbp_v_ods.V_ods_bon_retoure_2 v
ON k.bon_id = v.bon_id
AND k.mandant_id = v.mandant_id
AND k.wup_id = v.wup_id
WHERE (k.mandant_id, k.wup_id, k.bon_id) NOT IN (SELECT mandant_id, wup_id, bon_id FROM dbp_v_ods.V_ods_bon_storno_2)
AND k.turnover_fg = 1
AND (k.mandant_id, k.wup_id, k.bon_dat) IN
(
SELECT
k.mandant_id
, k.wup_id
, k.dat_booking
FROM dbp_v_ods.V_bon_load_status_2 b
JOIN dbp_v_ods.V_ods_bon_transaction_2 k
ON k.datei_name = b.xml_name
WHERE k.kassensystem_name = 'KPOS'
/*AND CAST(b.IsFile_Time AS DATE) = DATE*/
/*AND k.bon_dat BETWEEN DATE-7 AND DATE-1*/
GROUP BY 1,2,3
)
GROUP BY 1,2,3
) t1_2

LEFT OUTER JOIN
(
SELECT
k.mandant_id
, k.wup_id
, k.bon_dat
, COUNT(k.bon_id) AS anz_end_of_days
, SUM(k.anz_kunden) AS anz_kunden_kassenabschluss
, SUM(k.anz_kunden_imbiss) AS anz_kunden_imbiss_kassenabschluss
, SUM(k.umsatz_brutto) AS umsatz_brutto_kassenabschluss
FROM dbp_v_ods.V_ods_bon_kassenabschluss_2 k
WHERE (k.mandant_id, k.wup_id, k.bon_dat) IN
(
SELECT
k.mandant_id
, k.wup_id
, k.dat_booking
FROM dbp_v_ods.V_bon_load_status_2 b
JOIN dbp_v_ods.V_ods_bon_transaction_2 k
ON k.datei_name = b.xml_name
WHERE k.kassensystem_name = 'KPOS'
/*AND CAST(b.IsFile_Time AS DATE) = DATE*/
/*AND k.bon_dat BETWEEN DATE-7 AND DATE-1*/
GROUP BY 1,2,3
)
GROUP BY 1,2,3
) t2
ON t1.mandant_id = t2.mandant_id
AND t1.wup_id = t2.wup_id
AND t1.dat_booking = t2.bon_dat

LEFT OUTER JOIN
(
SELECT
k.mandant_id
, k.wup_id
, k.dat
, k.bonanzahl
, k.bonanzahl_imbiss
FROM dbp_view.v_wupcal_2 k
WHERE (k.mandant_id, k.wup_id, k.dat) IN
(
SELECT
k.mandant_id
, k.wup_id
, k.dat_booking
FROM dbp_v_ods.V_bon_load_status_2 b
JOIN dbp_v_ods.V_ods_bon_transaction_2 k
ON k.datei_name = b.xml_name
WHERE k.kassensystem_name = 'KPOS'
/*AND CAST(b.IsFile_Time AS DATE) = DATE*/
/*AND k.bon_dat BETWEEN DATE-7 AND DATE-1*/
GROUP BY 1,2,3
)
) t3
ON t1.mandant_id = t3.mandant_id
AND t1.wup_id = t3.wup_id
AND t1.dat_booking = t3.dat

GROUP BY 1,2,3,4,5,6,7,8
HAVING differenz <> 0 OR differenz IS NULL
;
