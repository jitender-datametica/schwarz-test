CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_gp_system (mandant_id, tms_gp_id, nb_id, ewm_fg,
system_bez, tms_gp_id_anzeige, tms_gp_name) AS SELECT TG.mandant_id,
 TG.tms_gp_id,
 ll.nb_id,
 ll.ewm_fg,
  CASE
  WHEN ll.ewm_fg = 1
  THEN 'EWM'
  ELSE 'LES'
  END AS system_bez,
  CASE
  WHEN ll.ewm_fg = 1
  THEN ll.lagernummer_id_
  ELSE CAST(ll.wup_id AS STRING)
  END AS tms_gp_id_anzeige,
 TG.tms_gp_name
FROM kfl_production_dbp_view.v_tms_gp AS TG
 INNER JOIN kfl_production_dbp_view.v_l_system AS SYS ON TG.system_id = SYS.system_id
 INNER JOIN (SELECT mandant_id,
   wup_id,
   ewm_fg,
   nb_id,
   MAX(lagernummer_id) AS lagernummer_id_
  FROM kfl_production_dbp_data.l_lagernummer AS LL
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   ewm_fg) AS ll ON ll.wup_id = ROUND(SAFE_CAST(TG.tms_gp_id AS BIGNUMERIC), 0) AND TG.mandant_id = ll.mandant_id
WHERE TG.tms_gp_typ_cd = 'L'
 AND LEFT(SYS.system_bez, 4) = 'KTMS'
 AND LEFT(SYS.kl_system_bez, 3) <> 'FLW'
 AND TG.tms_gp_id NOT IN ('6921', '6922')
UNION DISTINCT
SELECT TG.mandant_id,
 TG.tms_gp_id,
 - 111 AS nb_id,
 2 AS ewm_fg,
 'FLW' AS system_bez,
 TG.tms_gp_id AS tms_gp_id_anzeige,
 TG.tms_gp_name
FROM kfl_production_dbp_view.v_tms_gp AS TG
 INNER JOIN kfl_production_dbp_view.v_l_system AS SYS ON TG.system_id = SYS.system_id
WHERE TG.tms_gp_id IN ('6921', '6922')
 AND LEFT(SYS.system_bez, 4) = 'KTMS'
 AND LEFT(SYS.kl_system_bez, 3) = 'FLW';