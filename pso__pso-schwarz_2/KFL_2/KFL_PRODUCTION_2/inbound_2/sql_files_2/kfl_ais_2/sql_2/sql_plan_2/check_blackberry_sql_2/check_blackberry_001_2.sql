
DELETE FROM DBP_MSI_DATA.check_blackberry_2
WHERE dat IN ( SELECT dat FROM DBP_DATA.tag_2 WHERE akt_tag = 0)
;


INSERT INTO DBP_MSI_DATA.check_blackberry_2
(
dat
,mandant_id
,lieferquote_real
,lieferquote_def
,datenquote_real
,datenquote_def
,check_fg
,umsatz_ist
,umsatz_vj
,umsatz_plan
,umsatz_vortag
,umsatz_vorwoche
,kunden_ist
,kunden_vj
,bb_fg
,td_insert
,td_update
)
SELECT
COALESCE(dat,CURRENT_DATE-1)
, t06.mandant_id
, COALESCE(t05.flag_lieferung,-1) lieferquote_real
, t06.lieferquote lieferquote_def
, COALESCE(t05.flag_inhalt,-1) datenquote_real
, t06.datenquote datenquote_def
, CASE 
  WHEN flag_lieferung IS NULL THEN 1
  WHEN (lieferquote_real >lieferquote_def AND datenquote_real > datenquote_def) THEN 1 
  ELSE 0 END AS check_fg
, COALESCE(umsatz_ist,0) umsatz_ist
, COALESCE(umsatz_vj,0) umsatz_vj
, COALESCE(umsatz_plan,0) AS umsatz_plan
, COALESCE(umsatz_vortag,0) umsatz_vortag
, COALESCE(umsatz_vorwoche,0) umsatz_vorwoche
, COALESCE(kunden_ist,0) kunden_ist
, COALESCE(kunden_vj,0) kunden_vj
, CASE 
  WHEN flag_lieferung IS NULL THEN 1
  WHEN (lieferquote_real >lieferquote_def AND datenquote_real > datenquote_def) THEN 1 
  ELSE 0 END 
  AS bb_fg
,CURRENT_TIMESTAMP
,CURRENT_TIMESTAMP
FROM
(    SELECT DISTINCT
t01.mandant_id
, COALESCE(t01.dat, t02.dat, t03.dat) dat
, CAST (CAST((ZEROIFNULL(t01.count_wup) - ZEROIFNULL(t02.count_wup_ber)) AS FLOAT)  / t01.count_wup * 100 AS DECIMAL (18,2)) flag_lieferung
, CAST (CAST((ZEROIFNULL(t01.count_wup) - ZEROIFNULL(t03.count_wup_plausi)) AS FLOAT)  / t01.count_wup * 100 AS DECIMAL (18,2)) flag_inhalt
FROM
(    SELECT t01.dat, t01.mandant_id, ZEROIFNULL(COUNT(t01.wup_id)) count_wup
FROM DBP_DATA.wupcal_2 t01
JOIN DBP_DATA.tag_2 t02
ON (t01.dat = t02.dat AND TRIM(EXTRACT(DAY FROM t01.dat-364)) ||'.'|| TRIM(EXTRACT(MONTH FROM t01.dat-364)) = TRIM(EXTRACT(DAY FROM t02.dat-364)) ||'.'|| TRIM(EXTRACT(MONTH FROM t02.dat-364)))
WHERE (t02.akt_tag = 0 AND t01.offen = 1 AND t01.nb_id IN (0))
GROUP BY t01.dat, t01.mandant_id
) t01

FULL OUTER JOIN
(    SELECT
t01.dat
, t01.mandant_id
, COUNT(t01.wup_id) count_wup_ber
FROM DBP_DATA.wupcal_2 t01
JOIN DBP_DATA.tag_2 t02
ON (t01.dat = t02.dat AND TRIM(EXTRACT(DAY FROM t01.dat-364)) ||'.'|| TRIM(EXTRACT(MONTH FROM t01.dat-364)) = TRIM(EXTRACT(DAY FROM t02.dat-364)) ||'.'|| TRIM(EXTRACT(MONTH FROM t02.dat-364)))
WHERE (t02.akt_tag = 0 AND t01.offen = 1 AND t01.nb_id IN (0) AND t01.datenlieferung_artbew_wg_sum IN (0, 2))
GROUP BY t01.dat, t01.mandant_id
) t02
ON (t01.dat = t02.dat AND t01.mandant_id = t02.mandant_id)

FULL OUTER JOIN
(    SELECT
t01.dat
, t01.mandant_id
, COUNT(t01.wup_id) count_wup_plausi
FROM DBP_DATA.wupcal_2 t01
JOIN DBP_DATA.tag_2 t02
ON (t01.dat = t02.dat AND TRIM(EXTRACT(DAY FROM t01.dat-364)) ||'.'|| TRIM(EXTRACT(MONTH FROM t01.dat-364)) = TRIM(EXTRACT(DAY FROM t02.dat-364)) ||'.'|| TRIM(EXTRACT(MONTH FROM t02.dat-364)))
WHERE (t02.akt_tag = 0 AND t01.offen = 1 AND t01.nb_id IN (0) AND (t01.pruef_status_id_umsatz <= 0))
GROUP BY t01.dat, t01.mandant_id
) t03
ON (t01.dat = t03.dat AND t01.mandant_id = t03.mandant_id)

) t05
FULL OUTER JOIN DBP_MSI_DATA.mis_lieferquote_2 t06
ON (t05.mandant_id = t06.mandant_id)

JOIN
(    SELECT
mandant_id
, MAX(umsatz_ist) umsatz_ist
, MAX(umsatz_vj) umsatz_vj
, MAX(umsatz_plan) umsatz_plan
, MAX(umsatz_vortag) umsatz_vortag
, MAX(umsatz_vorwoche) umsatz_vorwoche
, MAX(kunden_ist) kunden_ist
, MAX(kunden_vj) kunden_vj
FROM
( SELECT

  t01.mandant_id
, CASE WHEN t02.akt_tag = 0 THEN SUM(ums_netto) END AS umsatz_ist
, CASE WHEN t02.akt_tag = 0 THEN SUM(ums_netto_wvj) END AS umsatz_vj
, CASE WHEN t02.akt_tag = 0 THEN SUM(ums_netto_plan) END AS umsatz_plan
, CASE WHEN t02.akt_tag = -1 THEN SUM(ums_netto) END AS umsatz_vortag
, CASE WHEN t02.akt_tag = -7 THEN SUM(ums_netto) END AS umsatz_vorwoche
, CASE WHEN t02.akt_tag = 0 THEN SUM(anz_kunde) END AS kunden_ist
, CASE WHEN t02.akt_tag = 0 THEN SUM(anz_kunde_wvj) END AS kunden_vj
FROM DBP_MSI_DATA.vis_tag_umsatz_kunde_wup_2 t01
JOIN DBP_DATA.tag_2 t02
ON (t01.dat = t02.dat)
WHERE t02.akt_tag IN (0,-1,-7) 
AND t01.nb_id = 0
AND t01.wrg_id = 'EUR'
GROUP BY t01.mandant_id, t02.akt_tag
) t01
GROUP BY t01.mandant_id
) t07
ON (t06.mandant_id = t07.mandant_id)
;

