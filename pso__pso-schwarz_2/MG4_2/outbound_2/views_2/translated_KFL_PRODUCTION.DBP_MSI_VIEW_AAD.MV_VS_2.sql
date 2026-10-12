-- 15.06.2023 snik: SPEC0200542 Lookup Region_2, analog KMR
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_vs_2 (mandant_id,
vs_id, ma_anrede, ma_name, ma_vorname, vsvt_bez) AS -- NUR bekannte eroeffnungen
 -- OHNE schliessungen
 SELECT v01.mandant_id
 ,
 v01.vs_id,
 v03.ma_anrede -- Dummy_2 gibt es nur für DE
,
  CASE
  WHEN v01.vs_id = 0 AND v01.mandant_id = 1
  THEN ''
  ELSE v03.ma_name
  END AS ma_name,
 v03.ma_vorname,
 v01.vsvt_bez
FROM kfl_production_dbp_view.v_vs_2 AS v01
 INNER JOIN (SELECT DISTINCT w.mandant_id,
   w.vs_id,
   MAX(wd.gl_vertrieb_id) OVER (PARTITION BY w.mandant_id, w.vs_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS gl_vertrieb_id
  FROM kfl_production_dbp_view.v_wup_2 AS w
   LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS wd ON w.mandant_id = wd.mandant_id AND w.wup_id = wd.wup_id
  WHERE w.nb_id IN (- 2, - 1, 0)
   AND w.dat_eroeffnung < DATE '9999-12-31'
   AND w.dat_bis = DATE '9999-12-31') AS v02 ON v01.mandant_id = v02.mandant_id AND v01.vs_id = v02.vs_id
 LEFT JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS v03 ON v02.mandant_id = v03.mandant_id AND v02.gl_vertrieb_id = v03.ma_id
     AND v03.spr_id = 22;