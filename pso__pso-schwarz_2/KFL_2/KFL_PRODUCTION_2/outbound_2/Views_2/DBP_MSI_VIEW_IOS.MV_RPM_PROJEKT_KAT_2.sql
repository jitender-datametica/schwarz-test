CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_projekt_kat_2 AS SELECT DISTINCT CAST(CASE
   WHEN rpm_projekt_typ_id IN ('DM', 'FM', 'LM', 'NB_2', 'UB', 'UE', 'XP')
   THEN '1EX'
   WHEN rpm_projekt_typ_id IN ('MM_2', 'MO', 'RE_2', 'RN', 'ST')
   THEN '2MM_2'
   WHEN rpm_projekt_typ_id IN ('IG', 'PM_2')
   THEN '3IG'
   WHEN rpm_projekt_typ_id IN ('BM', 'SM_2', 'WM_2')
   THEN '4SB'
   WHEN rpm_projekt_typ_id IN ('GM', 'KM')
   THEN '5KM'
   WHEN rpm_projekt_typ_id IN ('KO')
   THEN '6KO'
   WHEN rpm_projekt_typ_id IN ('DB', 'FB', 'FK', 'LB', 'LK', 'LO', 'NF', 'NV', 'NW', 'RF', 'RL', 'RS_2', 'RV', 'SF', 'VK_2', 'WR')
   THEN '7LF'
   ELSE '8SO'
   END AS STRING) AS rpm_projekt_kat,
 CAST(CASE
   WHEN rpm_projekt_typ_id IN ('DM', 'FM', 'LM', 'NB_2', 'UB', 'UE', 'XP')
   THEN 'Expansion'
   WHEN rpm_projekt_typ_id IN ('MM_2', 'MO', 'RE_2', 'RN', 'ST')
   THEN 'Marktmodernisierung'
   WHEN rpm_projekt_typ_id IN ('IG', 'PM_2')
   THEN 'Gro\u00dfreparaturen'
   WHEN rpm_projekt_typ_id IN ('BM', 'SM_2', 'WM_2')
   THEN 'Sonstige Bauma\u00dfnahmen'
   WHEN rpm_projekt_typ_id IN ('GM', 'KM')
   THEN 'Kleinma\u00dfnahmen'
   WHEN rpm_projekt_typ_id IN ('KO')
   THEN 'Konzessionärsma\u00dfnahmen'
   WHEN rpm_projekt_typ_id IN ('DB', 'FB', 'FK', 'LB', 'LK', 'LO', 'NF', 'NV', 'NW', 'RF', 'RL', 'RS_2', 'RV', 'SF', 'VK_2', 'WR')
   THEN 'LOG, VW, FLW'
   ELSE 'Sonstige Investitionen'
   END AS STRING) AS rpm_projekt_kat_bez
FROM kfl_production_dbp_view.v_l_rpm_phase_2 AS LRP
WHERE LENGTH(TRIM(rpm_projekt_typ_id)) BETWEEN 2 AND 3;