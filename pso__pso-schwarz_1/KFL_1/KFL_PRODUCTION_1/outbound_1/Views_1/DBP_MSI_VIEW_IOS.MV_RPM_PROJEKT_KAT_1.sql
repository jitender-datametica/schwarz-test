CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_projekt_kat_1 AS SELECT DISTINCT CAST(CASE
   WHEN rpm_projekt_typ_id IN ('DM', 'FM', 'LM', 'NB_1', 'UB', 'UE', 'XP')
   THEN '1EX'
   WHEN rpm_projekt_typ_id IN ('MM_1', 'MO', 'RE_1', 'RN', 'ST')
   THEN '2MM_1'
   WHEN rpm_projekt_typ_id IN ('IG', 'PM_1')
   THEN '3IG'
   WHEN rpm_projekt_typ_id IN ('BM', 'SM_1', 'WM_1')
   THEN '4SB'
   WHEN rpm_projekt_typ_id IN ('GM', 'KM')
   THEN '5KM'
   WHEN rpm_projekt_typ_id IN ('KO')
   THEN '6KO'
   WHEN rpm_projekt_typ_id IN ('DB', 'FB', 'FK', 'LB', 'LK', 'LO', 'NF', 'NV', 'NW', 'RF', 'RL', 'RS_1', 'RV', 'SF', 'VK_1', 'WR')
   THEN '7LF'
   ELSE '8SO'
   END AS STRING) AS rpm_projekt_kat,
 CAST(CASE
   WHEN rpm_projekt_typ_id IN ('DM', 'FM', 'LM', 'NB_1', 'UB', 'UE', 'XP')
   THEN 'Expansion'
   WHEN rpm_projekt_typ_id IN ('MM_1', 'MO', 'RE_1', 'RN', 'ST')
   THEN 'Marktmodernisierung'
   WHEN rpm_projekt_typ_id IN ('IG', 'PM_1')
   THEN 'Gro\u00dfreparaturen'
   WHEN rpm_projekt_typ_id IN ('BM', 'SM_1', 'WM_1')
   THEN 'Sonstige Bauma\u00dfnahmen'
   WHEN rpm_projekt_typ_id IN ('GM', 'KM')
   THEN 'Kleinma\u00dfnahmen'
   WHEN rpm_projekt_typ_id IN ('KO')
   THEN 'Konzessionärsma\u00dfnahmen'
   WHEN rpm_projekt_typ_id IN ('DB', 'FB', 'FK', 'LB', 'LK', 'LO', 'NF', 'NV', 'NW', 'RF', 'RL', 'RS_1', 'RV', 'SF', 'VK_1', 'WR')
   THEN 'LOG, VW, FLW'
   ELSE 'Sonstige Investitionen'
   END AS STRING) AS rpm_projekt_kat_bez
FROM kfl_production_dbp_view.v_l_rpm_phase_1 AS LRP
WHERE LENGTH(TRIM(rpm_projekt_typ_id)) BETWEEN 2 AND 3;