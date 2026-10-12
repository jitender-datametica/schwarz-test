CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_sm_pm_ware_zu_2 AS SELECT VIS.mandant_id,
 VIS.nb_id,
 VIS.wup_id,
 HWG.abt_id,
 AVG(CASE
   WHEN PM.pm_id > - 1
   THEN PM.pm_id
   ELSE NULL
   END) OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.wup_id AS STRING), CAST(HWG.abt_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS abt_pm_id,
 AVG(CASE
   WHEN SM.sm_id > - 1
   THEN SM.sm_id
   ELSE NULL
   END) OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.wup_id AS STRING), CAST(HWG.abt_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS abt_sm_id,
 OWG.hwg_id,
 AVG(CASE
   WHEN PM.pm_id > - 1
   THEN PM.pm_id
   ELSE NULL
   END) OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.wup_id AS STRING), CAST(OWG.hwg_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS hwg_pm_id,
 AVG(CASE
   WHEN SM.sm_id > - 1
   THEN SM.sm_id
   ELSE NULL
   END) OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.wup_id AS STRING), CAST(OWG.hwg_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS hwg_sm_id,
 WG.owg_id,
 AVG(CASE
   WHEN PM.pm_id > - 1
   THEN PM.pm_id
   ELSE NULL
   END) OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.wup_id AS STRING), CAST(WG.owg_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS owg_pm_id,
 AVG(CASE
   WHEN SM.sm_id > - 1
   THEN SM.sm_id
   ELSE NULL
   END) OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), CAST(VIS.wup_id AS STRING), CAST(WG.owg_id AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS owg_sm_id,
 VIS.wg_id,
 COALESCE(PM.pm_id, - 1) AS wg_pm_id,
 COALESCE(SM.sm_id, - 1) AS wg_sm_id
FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg_2 AS VIS
 INNER JOIN kfl_production_dbp_data.tag_2 AS ZEIT_2 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.dat = CURRENT_DATE
 INNER JOIN kfl_production_dbp_data.wg_per_2 AS WG ON VIS.wg_id = WG.wg_id AND VIS.mandant_id = WG.mandant_id AND WG.dat_bis
    = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_data.owg_per_2 AS OWG ON WG.owg_id = OWG.owg_id AND WG.mandant_id = OWG.mandant_id AND OWG
   .dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_data.hwg_per_2 AS HWG ON OWG.hwg_id = HWG.hwg_id AND OWG.mandant_id = HWG.mandant_id AND
   HWG.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_data.sm_wup_wg_zu_per_2 AS SM_2 ON VIS.wup_id = SM.wup_id AND VIS.wg_id = SM.wg_id AND VIS.mandant_id
     = SM.mandant_id AND SM.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_data.pm_wup_wg_zu_per_2 AS PM_2 ON VIS.wup_id = PM.wup_id AND VIS.wg_id = PM.wg_id AND VIS.mandant_id
     = PM.mandant_id AND PM.dat_bis = DATE '9999-12-31'
WHERE VIS.wrg_id = 'EUR';