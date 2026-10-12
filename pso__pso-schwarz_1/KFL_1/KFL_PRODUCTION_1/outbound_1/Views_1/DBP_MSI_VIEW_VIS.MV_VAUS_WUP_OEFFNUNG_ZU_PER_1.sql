
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vaus_wup_oeffnung_zu_per_1 (wup_id, mandant_id, mo_zeit_von,
mo_zeit_bis, di_zeit_von, di_zeit_bis, mi_zeit_von, mi_zeit_bis, do_zeit_von, do_zeit_bis, fr_zeit_von, fr_zeit_bis,
sa_zeit_von, sa_zeit_bis, so_zeit_von, so_zeit_bis, heute_zeit_bis) AS SELECT V01.wup_id,
 V01.mandant_id,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 1
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS mo_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 1
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS mo_zeit_bis,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 2
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS di_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 2
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS di_zeit_bis,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 3
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS mi_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 3
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS mi_zeit_bis,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 4
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS do_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 4
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS do_zeit_bis,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 5
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS fr_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 5
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS fr_zeit_bis,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 6
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS sa_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 6
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS sa_zeit_bis,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 7
   THEN snowconvert_public.time_to_int_udf(V02.zeit_von)
   ELSE NULL
   END) AS so_zeit_von,
 MAX(CASE
   WHEN V02.wup_oeffnungs_typ_id = 7
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS so_zeit_bis,
 MAX(CASE
   WHEN CAST(FORMAT_DATE('%u', CURRENT_DATE) AS INTEGER) = V02.wup_oeffnungs_typ_id
   THEN snowconvert_public.time_to_int_udf(V02.zeit_bis)
   ELSE NULL
   END) AS heute_zeit_bis
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup_oeffnung_zu_per_1 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02
     .mandant_id AND V02.dat_bis = DATE '9999-12-31' AND V02.wup_oeffnungs_typ_id BETWEEN 1 AND 7
GROUP BY V01.wup_id,
 V01.mandant_id;

