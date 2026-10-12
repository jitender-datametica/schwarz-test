-- 20210916| SPEC0093956 | mayko | Initial view |
 -- 20220718| SPEC0158746 | richternic | neue Felder

-- 20230818 NSR3857733 steablern - Standardwerbetype MD von 6 auf 5 aendern

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_avq_werbezeitraum_abw AS
-- ,COALESCE(wwo.werbewoche,dv.kjwo)  as werbewoche
 -- ,COALESCE(wwo.kjmo,dv.kjmo) as werbemonat

-- ,CASE WHEN abw.mandant_id IS NOT NULL THEN 1 ELSE 0 END as abw_zeitr_fg
 -- kjwo = führend

-- folgewoche (wichtig beim jahreswechsel)
 -- Standardwerbetype pro Land
 SELECT wt.mandant_id,
 wt.werbe_typ_id,
 W.kjwo,
 COALESCE(abw.dat_von, DV.dat) AS dat_von,
 COALESCE(abw.dat_bis, DB.dat) AS dat_bis,
 DV.dat AS dat_von_orig,
 DB.dat AS dat_bis_orig,
 abw.kommentar
FROM kfl_production_dbp_view.v_woche AS W
 INNER JOIN kfl_production_dbp_view.v_woche AS FW ON DATE_ADD(W.wo_dat_bis, INTERVAL 1 DAY) = FW.wo_dat_von
 INNER JOIN (SELECT DISTINCT *
  FROM kfl_production_dbp_view.v_l_werbe_typ AS WT
  WHERE mandant_id IN (2, 6, 7) AND werbe_typ_id = 6
   OR mandant_id = 1 AND werbe_typ_id = 2
   OR mandant_id IN (3, 4, 5) AND werbe_typ_id = 5
   OR mandant_id = 8 AND werbe_typ_id = 7) AS wt ON TRUE
 INNER JOIN kfl_production_dbp_view.v_tag AS DV ON W.kjwo = DV.kjwo AND wt.wtag_id_start -- startdatum in der kw
 = DV.wtag_id
   
 INNER JOIN kfl_production_dbp_view.v_tag AS DB ON CASE
    WHEN wt.wtag_id_start > wt.wtag_id_ende
    THEN FW.kjwo
    ELSE W.kjwo
    END = DB.kjwo AND wt.wtag_id_ende -- enddatum ggfs. mit wochenuebergang
 = DB.wtag_id
 INNER JOIN (SELECT T0.mandant_id,
   T0.werbe_typ_id,
   T1.kjwo,
   T0.dat_bis,
   T0.dat_von,
   T0.kommentar
  FROM kfl_production_dbp_view.v_ts_avq_werbezeitraum_abw AS T0
   INNER JOIN kfl_production_dbp_view.v_tag AS T1 ON T0.dat_von = T1.dat) AS abw ON wt.mandant_id = abw.mandant_id AND
    wt.werbe_typ_id = abw.werbe_typ_id AND W.kjwo = abw.kjwo
   /* LEFT JOIN KFL_PRODUCTION.dbp_view.v_werbe_typ_woche_zu wwo
ON wt.mandant_id=wwo.mandant_id
AND wt.werbe_typ_id=wwo.werbe_typ_id
AND w.kjwo=wwo.kjwo */
   -- Einschränkung auf die aktuelle und die zukunftigen 11 Wochen - mehr wird in MSI nicht benoetig

WHERE W.akt_wo BETWEEN 0 AND 11;