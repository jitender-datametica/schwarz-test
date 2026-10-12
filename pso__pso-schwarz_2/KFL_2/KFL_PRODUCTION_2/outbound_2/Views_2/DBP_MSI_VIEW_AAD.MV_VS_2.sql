CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_vs_2 AS SELECT V01.mandant_id,
 V01.vs_id,
 V03.ma_anrede,
  CASE
  WHEN V01.vs_id = 0 AND V01.mandant_id = 1
  THEN ''
  ELSE V03.ma_name
  END AS ma_name,
 V03.ma_vorname,
 V01.vsvt_bez
FROM kfl_production_dbp_view.v_vs_2 AS V01
 INNER JOIN (SELECT DISTINCT W.mandant_id,
   W.vs_id,
   MAX(WD.gl_vertrieb_id) OVER (PARTITION BY CAST(W.mandant_id AS STRING), CAST(W.vs_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS gl_vertrieb_id
  FROM kfl_production_dbp_view.v_wup_2 AS W
   LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS WD ON W.mandant_id = WD.mandant_id AND W.wup_id = WD.wup_id
  WHERE W.nb_id IN (- 2, - 1, 0)
   AND W.dat_eroeffnung < DATE '9999-12-31'
   AND W.dat_bis = DATE '9999-12-31') AS v02 ON V01.mandant_id = v02.mandant_id AND V01.vs_id = v02.vs_id
 LEFT JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS V03 ON v02.mandant_id = V03.mandant_id AND v02.gl_vertrieb_id = V03.ma_id
     AND V03.spr_id = 22;