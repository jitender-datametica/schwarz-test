CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_massnahmenart AS SELECT DISTINCT rpm_projekt_typ_id,
 SUBSTR(CAST(SUBSTR(rpm_projekt_typ_id, 6, 2) AS STRING), 1, 2) AS rpm_massnahmenart_kbez,
  CASE
  WHEN rpm_projekt_typ_id = 'ZPPM_NB'
  THEN 1
  WHEN rpm_projekt_typ_id = 'ZPPM_UB'
  THEN 2
  WHEN rpm_projekt_typ_id = 'ZPPM_RN'
  THEN 3
  WHEN rpm_projekt_typ_id = 'ZPPM_ST'
  THEN 4
  WHEN rpm_projekt_typ_id = 'ZPPM_RE'
  THEN 5
  WHEN rpm_projekt_typ_id = 'ZPPM_RG'
  THEN 6
  WHEN rpm_projekt_typ_id IN ('ZPPM_RU', 'ZPPM_RX')
  THEN 7
  WHEN rpm_projekt_typ_id = 'ZPPM_TK'
  THEN 8
  WHEN rpm_projekt_typ_id = 'ZPPM_IH'
  THEN 9
  WHEN rpm_projekt_typ_id = 'ZPPM_SL'
  THEN 10
  WHEN rpm_projekt_typ_id = 'ZPPM_LO'
  THEN 11
  WHEN rpm_projekt_typ_id = 'ZPPM_RS'
  THEN 12
  WHEN rpm_projekt_typ_id = 'ZPPM_RL'
  THEN 13
  WHEN rpm_projekt_typ_id = 'ZPPM_NF'
  THEN 14
  WHEN rpm_projekt_typ_id = 'ZPPM_SF'
  THEN 15
  WHEN rpm_projekt_typ_id = 'ZPPM_RF'
  THEN 16
  WHEN rpm_projekt_typ_id = 'ZPPM_NV'
  THEN 17
  WHEN rpm_projekt_typ_id = 'ZPPM_RV'
  THEN 18
  WHEN rpm_projekt_typ_id = 'ZPPM_FK'
  THEN 19
  WHEN rpm_projekt_typ_id = 'ZPPM_GA'
  THEN 20
  WHEN rpm_projekt_typ_id = 'ZPPM_IG'
  THEN 21
  WHEN rpm_projekt_typ_id = 'ZPPM_LK'
  THEN 22
  WHEN rpm_projekt_typ_id = 'ZPPM_NW'
  THEN 23
  WHEN rpm_projekt_typ_id = 'ZPPM_TG'
  THEN 24
  WHEN rpm_projekt_typ_id = 'ZPPM_VK'
  THEN 25
  WHEN rpm_projekt_typ_id = 'ZPPM_WR'
  THEN 26
  WHEN rpm_projekt_typ_id = 'ZPPM_MM'
  THEN 27
  ELSE - 1
  END AS rpm_projektart_id,
  CASE
  WHEN rpm_projekt_typ_id = 'ZPPM_NB'
  THEN 'Neubau'
  WHEN rpm_projekt_typ_id = 'ZPPM_UB'
  THEN 'Übernahme'
  WHEN rpm_projekt_typ_id = 'ZPPM_RN'
  THEN 'Reorga nach Übernahme'
  WHEN rpm_projekt_typ_id = 'ZPPM_ST'
  THEN 'Standortoptimierung (SOA)'
  WHEN rpm_projekt_typ_id = 'ZPPM_RE'
  THEN 'Reorga (BERI)'
  WHEN rpm_projekt_typ_id = 'ZPPM_RG'
  THEN 'Rückfilialisierung (BERI)'
  WHEN rpm_projekt_typ_id IN ('ZPPM_RU', 'ZPPM_RX')
  THEN 'Ma\u00dfnahmen Landesgesellschaft'
  WHEN rpm_projekt_typ_id = 'ZPPM_TK'
  THEN 'Konzessionärsma\u00dfnahme'
  WHEN rpm_projekt_typ_id = 'ZPPM_IH'
  THEN 'Instandhaltungsma\u00dfnahme'
  WHEN rpm_projekt_typ_id = 'ZPPM_SL'
  THEN 'Schlie\u00dfung'
  WHEN rpm_projekt_typ_id = 'ZPPM_LO'
  THEN 'Neubau Logistik'
  WHEN rpm_projekt_typ_id = 'ZPPM_RS'
  THEN 'SOA Logistik'
  WHEN rpm_projekt_typ_id = 'ZPPM_RL'
  THEN 'Reorga Logistik'
  WHEN rpm_projekt_typ_id = 'ZPPM_NF'
  THEN 'Neubau Fleischwerk'
  WHEN rpm_projekt_typ_id = 'ZPPM_SF'
  THEN 'SOA Fleischwerk'
  WHEN rpm_projekt_typ_id = 'ZPPM_RF'
  THEN 'Reorga Fleischwerk'
  WHEN rpm_projekt_typ_id = 'ZPPM_NV'
  THEN 'Neubau Verwaltung'
  WHEN rpm_projekt_typ_id = 'ZPPM_RV'
  THEN 'Reorga Verwaltung'
  WHEN rpm_projekt_typ_id = 'ZPPM_FK'
  THEN 'Kleinma\u00dfnahmen Landesgesellschaft Fleischwerk'
  WHEN rpm_projekt_typ_id = 'ZPPM_GA'
  THEN 'Gastroma\u00dfnahmen'
  WHEN rpm_projekt_typ_id = 'ZPPM_IG'
  THEN 'Instandsetzungsma\u00dfnahmen (BERI)'
  WHEN rpm_projekt_typ_id = 'ZPPM_LK'
  THEN 'Kleinma\u00dfnahmen Landesgesellschaft Logistik'
  WHEN rpm_projekt_typ_id = 'ZPPM_NW'
  THEN 'Neubau "weitere Immobilien"'
  WHEN rpm_projekt_typ_id = 'ZPPM_TG'
  THEN 'Konzessionärsma\u00dfnahme BERI'
  WHEN rpm_projekt_typ_id = 'ZPPM_VK'
  THEN 'Kleinma\u00dfnahmen Landesgesellschaft Verwaltung'
  WHEN rpm_projekt_typ_id = 'ZPPM_WR'
  THEN 'Ma\u00dfnahmen an "weiteren Immobilien"'
  WHEN rpm_projekt_typ_id = 'ZPPM_MM'
  THEN 'Marktmodernisierung'
  ELSE 'Sonstige Ma\u00dfnahmenart'
  END AS rpm_massnahmenart_bez
FROM kfl_production_dbp_view.v_l_rpm_phase AS V01
WHERE SUBSTR(rpm_projekt_typ_id, 1, 4) = 'ZPPM';