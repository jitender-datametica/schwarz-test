CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vs (mandant_id, vs_id, vs_sort, vsvt_bez, vsvt_bez_cz,
vsvt_bez_sk, vsvt_bez_hr, vsvt_bez_pl, vsvt_bez_ro, vsvt_bez_bg, gl_vertrieb_id, ma_name, ma_vorname, ma_anrede, vk_id,
vs_bez, vsvt_bez_old) AS SELECT MDT.mandant_id,
 VSR.vs_id,
  CASE
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 7
  THEN 11
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 2
  THEN 12
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 3
  THEN 13
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 1
  THEN 14
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 8
  THEN 15
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 6
  THEN 16
  WHEN VSR.vs_id = 0
  THEN MDT.mandant_sort_id * 10 + 9
  ELSE MDT.mandant_sort_id * 10 + VSR.vs_id
  END AS vs_sort,
  CASE
  WHEN MDT.mandant_id = 1 AND VSR.vs_id = 0
  THEN 'Deutschland (NN)'
  WHEN MDT.mandant_id = 3 AND VSR.vs_id = 0
  THEN 'Polen'
  WHEN MDT.mandant_id = 7 AND VSR.vs_id = 0
  THEN 'Rumänien (NN)'
  WHEN MDT.mandant_id = 7 AND VSR.vs_id = 1
  THEN 'Rumänien West'
  WHEN MDT.mandant_id = 7 AND VSR.vs_id = 2
  THEN 'Rumänien Ost'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez,
  CASE
  WHEN MDT.mandant_id = 2 AND VSR.vs_id = 0
  THEN 'Česko'
  WHEN MDT.mandant_id = 5 AND VSR.vs_id = 0
  THEN 'Slovensko'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez_cz,
  CASE
  WHEN MDT.mandant_id = 2 AND VSR.vs_id = 0
  THEN 'Česko'
  WHEN MDT.mandant_id = 5 AND VSR.vs_id = 0
  THEN 'Slovensko'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez_sk,
  CASE
  WHEN MDT.mandant_id = 6 AND VSR.vs_id = 0
  THEN 'Hrvatska'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez_hr,
  CASE
  WHEN MDT.mandant_id = 3 AND VSR.vs_id = 0
  THEN 'Polska'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez_pl,
  CASE
  WHEN MDT.mandant_id = 4 AND VSR.vs_id = 0
  THEN 'Moldova'
  WHEN MDT.mandant_id = 7 AND VSR.vs_id = 0
  THEN 'România (NN)'
  WHEN MDT.mandant_id = 7 AND VSR.vs_id = 1
  THEN 'România Vest'
  WHEN MDT.mandant_id = 7 AND VSR.vs_id = 2
  THEN 'România Est'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez_ro,
  CASE
  WHEN MDT.mandant_id = 8 AND VSR.vs_id = 0
  THEN 'България'
  ELSE VSR.vsvt_bez
  END AS vsvt_bez_bg,
 COALESCE(wdw.gl_vertrieb_id, - 1) AS gl_vertrieb_id,
 COALESCE(msz.ma_name, '--') AS ma_name,
 COALESCE(msz.ma_vorname, '--') AS ma_vorname,
 msz.ma_anrede,
 VSR.vk_id,
 VSR.vs_bez,
 VSR.vsvt_bez AS vsvt_bez_old
FROM kfl_production_dbp_view.v_mandant AS MDT
 INNER JOIN kfl_production_dbp_view.v_vs AS VSR ON MDT.mandant_id = VSR.mandant_id
 INNER JOIN (SELECT DISTINCT WW.mandant_id,
   WW.vs_id,
   MAX(WD.gl_vertrieb_id) OVER (PARTITION BY CAST(WW.mandant_id AS STRING), CAST(WW.vs_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS gl_vertrieb_id
  FROM kfl_production_dbp_view.v_wup AS WW
   LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS WD ON WW.mandant_id = WD.mandant_id AND WW.wup_id = WD.wup_id
     
  WHERE WW.nb_id IN (- 1, 0)
   AND WW.dat_eroeffnung < PARSE_DATE('%F', '2090-12-30')
   AND WW.dat_bis = PARSE_DATE('%F', '9999-12-31')) AS wdw ON VSR.mandant_id = wdw.mandant_id AND VSR.vs_id = wdw.vs_id
 LEFT JOIN (SELECT mandant_id,
   ma_id,
   ma_name,
   ma_vorname,
   ma_anrede
  FROM kfl_production_dbp_view.v_ma_spr_zu
  WHERE spr_id = 22) AS msz ON wdw.mandant_id = msz.mandant_id AND wdw.gl_vertrieb_id = msz.ma_id;