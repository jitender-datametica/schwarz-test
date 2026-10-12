 --[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.wup_wotag_zu_per
WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD')
;


--translated statement
INSERT INTO DBP_DATA.wup_wotag_zu_per
(
  mandant_id
, wup_id
, nb_id
, wtag_id
, umsatz_prz
, dat_von
, dat_bis
)
SELECT
  dt1.mandant_id
, dt1.wup_id
, dt1.nb_id
, dt1.wtag_id
, CASE WHEN dt2.avg_umsatz_brutto = 0
       THEN 0
       ELSE dt1.avg_umsatz_brutto * 100.000 / (dt2.avg_umsatz_brutto)
  END
, CURRENT_DATE - EXTRACT(DAY FROM CURRENT_DATE)  --cast(DATE/100*100+1 AS DATE) - 1 - it results in last day of previous month
, to_date('9999-12-31','YYYY-MM-DD')             --80991231 /* = 31.12.9999 */
FROM
(SELECT
  aws.wup_id
, aws.nb_id
, aws.mandant_id
, t.wtag_id
, SUM(aws.umsatz_brutto) / COUNT(aws.dat) AS avg_umsatz_brutto
FROM DBP_DATA.artbew_wg_sum aws
INNER JOIN DBP_DATA.tag t
ON t.dat = aws.dat
AND t.dat > CURRENT_DATE -365
AND aws.bewart_id NOT IN (1005,1010) AND
    aws.nb_id NOT IN (2,7)
GROUP BY 
  aws.wup_id
, aws.nb_id
, aws.mandant_id
, t.wtag_id) dt1

INNER JOIN

(
SELECT
  wup_id
, nb_id
, mandant_id
, SUM(avg_umsatz_brutto) AS avg_umsatz_brutto
FROM
(SELECT
  aws.wup_id
, aws.nb_id
, aws.mandant_id
, t.wtag_id
, SUM(aws.umsatz_brutto) / COUNT(aws.dat) AS avg_umsatz_brutto
FROM DBP_DATA.artbew_wg_sum aws
INNER JOIN DBP_DATA.tag t
ON t.dat = aws.dat
AND t.dat > CURRENT_DATE -365
AND aws.bewart_id NOT IN (1005,1010) AND
    aws.nb_id NOT IN (2,7)
GROUP BY 
  aws.wup_id
, aws.nb_id
, aws.mandant_id
, t.wtag_id ) dt3
GROUP BY 
  wup_id
, nb_id
, mandant_id
) dt2

ON dt1.mandant_id = dt2.mandant_id
AND dt1.wup_id    = dt2.wup_id
AND dt1.nb_id     = dt2.nb_id
;


--translated statement
UPDATE DBP_DATA.wup_wotag_zu_per

SET dat_bis = dt1.dat_bis
FROM
(SELECT 
  mandant_id
, wup_id
, nb_id
, wtag_id
, dat_von
--, CASE WHEN (MSUM(CAST(dat_von AS INTEGER), 2, mandant_id, wup_id, nb_id, wtag_id, dat_von desc)-CAST(dat_von AS INTEGER)) <> 0
--       THEN CAST((MSUM(CAST(dat_von AS INTEGER), 2, mandant_id, wup_id, nb_id, wtag_id, dat_von desc)-CAST(dat_von AS INTEGER)) AS DATE) -1
--       ELSE to_date('9999-12-31','YYYY-MM-DD')
--  END AS dat_bis
, coalesce(LAG (dat_von,1) OVER (PARTITION BY mandant_id, wup_id, nb_id, wtag_id ORDER BY dat_von desc)-1, to_date('9999-12-31','YYYY-MM-DD')) AS dat_bis
FROM DBP_DATA.wup_wotag_zu_per
--GROUP BY mandant_id, wup_id, nb_id, wtag_id
) dt1 WHERE wup_wotag_zu_per.mandant_id = dt1.mandant_id
AND wup_wotag_zu_per.wup_id       = dt1.wup_id
AND wup_wotag_zu_per.nb_id        = dt1.nb_id
AND wup_wotag_zu_per.wtag_id      = dt1.wtag_id
AND wup_wotag_zu_per.dat_von      = dt1.dat_von
;

