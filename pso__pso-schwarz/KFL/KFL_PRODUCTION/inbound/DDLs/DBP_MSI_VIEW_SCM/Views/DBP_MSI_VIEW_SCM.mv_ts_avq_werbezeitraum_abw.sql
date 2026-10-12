CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_AVQ_WERBEZEITRAUM_ABW AS
-- 20210916| SPEC0093956 | mayko | Initial view |
-- 20220718| SPEC0158746 | richternic | neue Felder 
-- 20230818 NSR3857733 steablern - Standardwerbetype MD von 6 auf 5 aendern 
SELECT
wt.mandant_id
,wt.werbe_typ_id
,w.kjwo
,COALESCE(abw.dat_von,dv.dat) AS dat_von
,COALESCE(abw.dat_bis,db.dat) AS dat_bis
,dv.dat AS dat_von_orig
,db.dat AS dat_bis_orig
--,COALESCE(wwo.werbewoche,dv.kjwo)  as werbewoche
--,COALESCE(wwo.kjmo,dv.kjmo) as werbemonat 
--,CASE WHEN abw.mandant_id IS NOT NULL THEN 1 ELSE 0 END as abw_zeitr_fg
,abw.kommentar
FROM dbp_view.v_woche w --kjwo = führend

JOIN dbp_view.v_woche fw --folgewoche (wichtig beim jahreswechsel)
ON w.wo_dat_bis+1 = fw.wo_dat_von

CROSS JOIN --Standardwerbetype pro Land 
    (SELECT DISTINCT MANDANT_ID, WERBE_TYP_ID, WTAG_ID_START, WTAG_ID_ENDE 
     FROM dbp_view.v_l_werbe_typ wt
     WHERE (MANDANT_ID IN (2,6,7) AND WERBE_TYP_ID = 6)
     OR (MANDANT_ID = 1 AND WERBE_TYP_ID = 2)
     OR (MANDANT_ID IN (3,4,5) AND WERBE_TYP_ID = 5)
     OR (MANDANT_ID = 8 AND WERBE_TYP_ID = 7)
     ) wt

JOIN dbp_view.v_tag dv
ON dv.kjwo=w.kjwo
AND dv.wtag_id=wt.wtag_id_start --startdatum in der kw

JOIN dbp_view.v_tag db
ON (CASE WHEN wt.wtag_id_start > wtag_id_ende THEN fw.kjwo ELSE  w.kjwo END ) = db.kjwo
AND db.wtag_id=wt.wtag_id_ende --enddatum ggfs. mit wochenuebergang

JOIN (SELECT t0.mandant_id, t0.werbe_typ_id, t1.kjwo, t0.dat_bis , t0.dat_von , t0.kommentar
           FROM dbp_view.v_ts_avq_werbezeitraum_abw t0 
           JOIN dbp_view.v_tag t1 ON t0.dat_von=t1.dat ) abw
ON wt.mandant_id=abw.mandant_id
AND wt.werbe_typ_id=abw.werbe_typ_id
AND w.kjwo=abw.kjwo

/*LEFT JOIN dbp_view.v_werbe_typ_woche_zu wwo
ON wt.mandant_id=wwo.mandant_id
AND wt.werbe_typ_id=wwo.werbe_typ_id
AND w.kjwo=wwo.kjwo*/

-- Einschränkung auf die aktuelle und die zukunftigen 11 Wochen - mehr wird in MSI nicht benoetig
WHERE w.akt_wo BETWEEN 0 AND 11 
;