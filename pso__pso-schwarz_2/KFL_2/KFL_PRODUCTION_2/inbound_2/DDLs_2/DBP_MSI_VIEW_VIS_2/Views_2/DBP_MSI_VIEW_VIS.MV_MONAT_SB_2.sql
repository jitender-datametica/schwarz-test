CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MONAT_SB_2 as
   -- Lookup View für Monate ohne Bezug zu Jahr (für SB)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT
   v01.mo_kj, v01.mo_gj, v01.akt_mo, MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez      --standard=deutsch
   , MAX(CASE WHEN v02.spr_id =  22 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_de   --deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_cz   --tschechisch
   , MAX(CASE WHEN v02.spr_id =  90 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_pl   --polnisch
   , MAX(CASE WHEN v02.spr_id = 108 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_sk   --slowakisch
   , MAX(CASE WHEN v02.spr_id =  65 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_hr   --kroatisch
   , MAX(CASE WHEN v02.spr_id =  95 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_ro   --rumänisch
   , MAX(CASE WHEN v02.spr_id =  18 THEN v02.mo_bez ELSE NULL END)::VARCHAR(20) AS mo_bez_bg   --bulgarisch
   , MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez      --standard=deutsch
   , MAX(CASE WHEN v02.spr_id =  22 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_de   --deutsch
   , MAX(CASE WHEN v02.spr_id = 124 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_cz   --tschechisch
   , MAX(CASE WHEN v02.spr_id =  90 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_pl   --polnisch
   , MAX(CASE WHEN v02.spr_id = 108 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_sk   --slowakisch
   , MAX(CASE WHEN v02.spr_id =  65 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_hr   --kroatisch
   , MAX(CASE WHEN v02.spr_id =  95 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_ro   --rumänisch
   , MAX(CASE WHEN v02.spr_id =  18 THEN TRIM(SUBSTRING(v02.mo_bez, 1, 3)) ELSE NULL END)::VARCHAR(20) AS mo_kbez_bg   --bulgarisch
   FROM dbp_view.v_monat_2 v01
   INNER JOIN dbp_view.v_monat_spr_zu_2 v02
   ON v01.mo_kj = v02.mo_id
   AND v01.akt_gj = 0
   GROUP BY
   v01.mo_kj
   ,v01.mo_gj
   ,v01.akt_mo;