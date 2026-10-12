
DELETE FROM DBP_DATA.wup_wotag_zu_per_1
WHERE dat_von = last_day(dat_von);


INSERT INTO DBP_DATA.wup_wotag_zu_per_1
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
, last_day(current_date())
, TO_DATE('99991231','YYYYMMDD') /* = 31.12.9999 */
FROM
(SELECT
  aws.wup_id
, aws.nb_id
, aws.mandant_id
, t.wtag_id
, SUM(aws.umsatz_brutto) / COUNT(aws.dat) AS avg_umsatz_brutto
FROM DBP_DATA.artbew_wg_sum_1 aws

INNER JOIN DBP_DATA.tag_1 t
ON t.dat = aws.dat
AND t.dat > CURRENT_DATE -365
AND aws.bewart_id NOT IN (1005,1010)
AND aws.nb_id NOT IN (2,7)
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
FROM DBP_DATA.artbew_wg_sum_1 aws

INNER JOIN DBP_ETL.vis_mandant_1 vm
ON aws.mandant_id = vm.mandant_id

INNER JOIN DBP_DATA.tag_1 t
ON t.dat = aws.dat
AND t.dat > CURRENT_DATE -365
AND aws.bewart_id NOT IN (1005,1010)
AND aws.nb_id NOT IN (2,7)
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



UPDATE DBP_DATA.wup_wotag_zu_per_1

SET dat_bis                       = dt1.dat_bis
FROM
(SELECT 
  t.mandant_id
, t.wup_id
, t.nb_id
, t.wtag_id
, t.dat_von
, t.dat_bis
from (  
  SELECT 
  wp.mandant_id
, wp.wup_id
, wp.nb_id
, wp.wtag_id
, wp.dat_von
, 
CASE 
  WHEN 
  SUM(TO_NUMBER(to_char(WP.dat_von ,'YYYYMMDD'),'99999999')) OVER (PARTITION BY wp.mandant_id, wp.wup_id, wp.nb_id, wp.wtag_id ORDER BY wp.mandant_id, wp.wup_id, wp.nb_id, wp.wtag_id, wp.dat_von desc  ROWS 1 PRECEDING) - TO_NUMBER(to_char(wp.dat_von ,'YYYYMMDD'),'99999999') <> 0
THEN DATE(SUM(TO_NUMBER(to_char(WP.dat_von ,'YYYYMMDD'),'99999999')) OVER (PARTITION BY wp.mandant_id, wp.wup_id, wp.nb_id, wp.wtag_id ORDER BY wp.mandant_id, wp.wup_id, wp.nb_id, wp.wtag_id, wp.dat_von desc  ROWS 1 PRECEDING) - TO_NUMBER(to_char(wp.dat_von ,'YYYYMMDD'),'99999999'),'yyyymmdd') -1
ELSE date('99991231', 'yyyymmdd')
END AS dat_bis
FROM DBP_DATA.wup_wotag_zu_per_1 wp

 ) as t
GROUP BY t.mandant_id, t.wup_id, t.nb_id, t.wtag_id, t.dat_von, t.dat_bis
) dt1 WHERE wup_wotag_zu_per.mandant_id = dt1.mandant_id
AND wup_wotag_zu_per.wup_id       = dt1.wup_id
AND wup_wotag_zu_per.nb_id        = dt1.nb_id
AND wup_wotag_zu_per.wtag_id      = dt1.wtag_id
AND wup_wotag_zu_per.dat_von      = dt1.dat_von
;

