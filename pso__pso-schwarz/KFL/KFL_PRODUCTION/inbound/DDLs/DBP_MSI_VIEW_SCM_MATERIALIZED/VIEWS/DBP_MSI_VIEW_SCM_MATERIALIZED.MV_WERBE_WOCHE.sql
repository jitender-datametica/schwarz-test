create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WERBE_WOCHE(
	MANDANT_ID,
	WERBE_TYP_ID,
	KJWO,
	WERBEWOCHE,
	WERBEMONAT,
	ABW_ZEITR_FG,
	ANZ_DAT_VON,
	ANZ_DAT_BIS,
	SUFFIX,
	DAT_VON,
	DAT_BIS,
	WW_VON_BIS
) as
--2024-03-20, dknop, copy from VIS
SELECT 
mandant_id,
werbe_typ_id,
kjwo, 
werbewoche,
werbemonat,
abw_zeitr_fg,
COUNT(DISTINCT dat_von_) AS anz_dat_von,
COUNT(DISTINCT dat_bis_) AS anz_dat_bis,
CASE WHEN anz_dat_von+anz_dat_bis > 2 THEN ' [!]' ELSE '' END AS suffix,
MIN(dat_von_) AS dat_von,
MAX(dat_bis_) AS dat_bis,
CAST( to_varchar(dat_von , 'DD.MM.YYYY') || ' - ' || to_varchar(dat_bis , 'DD.MM.YYYY') || suffix AS VARCHAR(100)) AS ww_von_bis
FROM
(
SELECT
wt.mandant_id
,wt.werbe_typ_id
,w.kjwo
,COALESCE(abw.dat_von,dv.dat) AS dat_von_
,COALESCE(abw.dat_bis,db.dat) AS dat_bis_
,COALESCE(wwo.werbewoche,dv.kjwo)  AS werbewoche
,COALESCE(wwo.kjmo,dv.kjmo) AS werbemonat 
,CASE WHEN abw.mandant_id IS NOT NULL THEN 1 ELSE 0 END AS abw_zeitr_fg
FROM dbp_view.v_woche w --kjwo = führend
JOIN dbp_view.v_woche fw --folgewoche (wichtig beim jahreswechsel)
ON w.wo_dat_bis+1 = fw.wo_dat_von
CROSS JOIN dbp_view.v_l_werbe_typ wt --alle werbetpyen
JOIN dbp_view.v_tag dv
ON dv.kjwo=w.kjwo
AND dv.wtag_id=wt.wtag_id_start --startdatum in der kw
JOIN dbp_view.v_tag db
ON (CASE WHEN wt.wtag_id_start > wtag_id_ende OR wt.werbe_typ_id=15 THEN fw.kjwo ELSE  w.kjwo END ) = db.kjwo
AND db.wtag_id=wt.wtag_id_ende --enddatum ggfs. mit wochenuebergang
LEFT JOIN (SELECT t0.mandant_id, t0.werbe_typ_id, t1.kjwo, t0.dat_bis , t0.dat_von FROM dbp_view.v_ts_avq_werbezeitraum_abw t0 JOIN dbp_view.v_tag t1 ON t0.dat_von=t1.dat ) abw
ON wt.mandant_id=abw.mandant_id
AND wt.werbe_typ_id=abw.werbe_typ_id
AND w.kjwo=abw.kjwo
LEFT JOIN dbp_view.v_werbe_typ_woche_zu wwo
ON wt.mandant_id=wwo.mandant_id
AND wt.werbe_typ_id=wwo.werbe_typ_id
AND w.kjwo=wwo.kjwo
WHERE w.kjwo BETWEEN EXTRACT(YEAR FROM CURRENT_DATE()) - 2 || '01' AND (SELECT kjwo FROM dbp_view.v_tag WHERE dat = CURRENT_DATE())
) t0
GROUP BY
mandant_id,
werbe_typ_id,
kjwo, 
werbewoche,
werbemonat,
abw_zeitr_fg;