CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kasse_typ_per (mandant_id, wup_id, nb_id, dat, kasse_nr,
kasse_typ_id, sco, dat_von, dat_bis) AS SELECT WUP.mandant_id,
 WUP.wup_id,
 WUP.nb_id,
 sub.dat,
 sub.kasse_nr,
 sub.kasse_typ_id,
 LAST_VALUE(CASE
   WHEN sub.kasse_typ_id IN (8, 9, 10, 11)
   THEN 'Ja'
   ELSE 'Nein'
   END) OVER (PARTITION BY CAST(sub.mandant_id AS STRING), CAST(sub.wup_id AS STRING), CAST(sub.kasse_nr AS STRING)
  ORDER BY sub.dat IS NULL, sub.dat RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sco,
 sub.dat_von,
 sub.fixed_dat_bis AS dat_bis
FROM kfl_production_dbp_view.v_wup AS WUP
 LEFT JOIN (SELECT KTP.mandant_id,
   KTP.nb_id,
   WUP0.aktuell_wup_id AS wup_id,
   ZEIT.dat,
   KTP.kasse_nr,
   KTP.kasse_typ_id,
   KTP.dat_von,
   KTP.dat_bis AS ktp_dat_bis,
   WUP0.dat_bis AS wup_dat_bis,
    CASE
    WHEN KTP.dat_bis <= WUP0.dat_bis
    THEN KTP.dat_bis
    ELSE WUP0.dat_bis
    END AS fixed_dat_bis
  FROM kfl_production_dbp_view.v_kasse_typ_per AS KTP
   INNER JOIN kfl_production_dbp_view.v_wup AS WUP0 ON KTP.mandant_id = WUP0.mandant_id AND KTP.wup_id = WUP0.wup_id
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT ON ZEIT.dat BETWEEN KTP.dat_von AND CASE
      WHEN KTP.dat_bis <= WUP0.dat_bis
      THEN KTP.dat_bis
      ELSE WUP0.dat_bis
      END AND ZEIT.dat BETWEEN IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 36
        MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 36 MONTH)) AND (CURRENT_DATE)) AS sub ON WUP.mandant_id = sub.mandant_id
    AND WUP.wup_id = sub.wup_id
WHERE WUP.wup_id = WUP.aktuell_wup_id
 AND WUP.umzugsfiliale_fg = 0;