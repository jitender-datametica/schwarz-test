CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_vaus_wup_oeffnung_2 (mo_zeit_von, mo_zeit_bis, di_zeit_von,
di_zeit_bis, mi_zeit_von, mi_zeit_bis, do_zeit_von, do_zeit_bis, fr_zeit_von, fr_zeit_bis, sa_zeit_von, sa_zeit_bis,
so_zeit_von, so_zeit_bis) AS SELECT COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 1
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS mo_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 1
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS mo_zeit_bis,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 2
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS di_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 2
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS di_zeit_bis,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 3
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS mi_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 3
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS mi_zeit_bis,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 4
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS do_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 4
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS do_zeit_bis,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 5
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS fr_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 5
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS fr_zeit_bis,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 6
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS sa_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 6
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS sa_zeit_bis,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 7
   THEN zeit_von
   ELSE NULL
   END, TIME '00:00:00') AS so_zeit_von,
 COALESCE(CASE
   WHEN wup_oeffnungs_typ_id = 7
   THEN zeit_bis
   ELSE NULL
   END, TIME '00:00:00') AS so_zeit_bis
FROM kfl_production_dbp_view.v_vaus_wup_oeffnung_zu_per_2 AS V02
WHERE dat_bis = DATE '9999-12-31'
 AND wup_oeffnungs_typ_id BETWEEN 1 AND 7
GROUP BY mo_zeit_von,
 mo_zeit_bis,
 di_zeit_von,
 di_zeit_bis,
 mi_zeit_von,
 mi_zeit_bis,
 do_zeit_von,
 do_zeit_bis,
 fr_zeit_von,
 fr_zeit_bis,
 sa_zeit_von,
 sa_zeit_bis,
 so_zeit_von,
 so_zeit_bis;