CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_MASSNAHMENART_2 as
   -- ZUORDNUNG projekt_typ > massnahmenart < KEINE saubere LOOKUP
   -- kkaiser 130911 - Massnahmen erweitert
   -- 2016-02-17 ssch0611 : temp. Anpassung MM_2 >> benoetigt Review


   SELECT DISTINCT
   v01.rpm_projekt_typ_id, SUBSTRING(v01.rpm_projekt_typ_id, 6, 2)::CHAR(2) AS rpm_massnahmenart_kbez, CASE
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NB'  THEN 1
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_UB'  THEN 2
   WHEN v01.rpm_projekt_typ_id ='ZPPM_RN'   THEN 3
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_ST'  THEN 4
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RE'  THEN 5
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RG'   THEN 6
   WHEN v01.rpm_projekt_typ_id IN ('ZPPM_RU', 'ZPPM_RX') THEN 7
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_TK'  THEN 8
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_IH'  THEN 9
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_SL'  THEN 10
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_LO'  THEN 11
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RS'  THEN 12
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RL'  THEN 13
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NF'  THEN 14
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_SF'  THEN 15
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RF'  THEN 16
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NV'  THEN 17
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RV'  THEN 18
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_FK'  THEN 19
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_GA'  THEN 20
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_IG'  THEN 21
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_LK'  THEN 22
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NW'  THEN 23
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_TG'  THEN 24
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_VK'  THEN 25
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_WR'  THEN 26
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_MM'  THEN 27

   ELSE -1  END AS rpm_projektart_id, CASE
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NB'  THEN 'Neubau'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_UB'  THEN 'Übernahme'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RN'  THEN 'Reorga nach Übernahme'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_ST'  THEN 'Standortoptimierung (SOA)'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RE'  THEN 'Reorga (BERI)'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RG'  THEN 'Rückfilialisierung (BERI)'
   WHEN v01.rpm_projekt_typ_id IN ('ZPPM_RU', 'ZPPM_RX') THEN 'Maßnahmen Landesgesellschaft'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_TK'  THEN 'Konzessionärsmaßnahme'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_IH'  THEN 'Instandhaltungsmaßnahme'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_SL'  THEN 'Schließung'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_LO'  THEN 'Neubau Logistik'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RS'  THEN 'SOA Logistik'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RL'  THEN 'Reorga Logistik'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NF'  THEN 'Neubau Fleischwerk'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_SF'  THEN 'SOA Fleischwerk'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RF'  THEN 'Reorga Fleischwerk'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NV'  THEN 'Neubau Verwaltung'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_RV'  THEN 'Reorga Verwaltung'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_FK'  THEN 'Kleinmaßnahmen Landesgesellschaft Fleischwerk'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_GA'  THEN 'Gastromaßnahmen'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_IG'  THEN 'Instandsetzungsmaßnahmen (BERI)'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_LK'  THEN 'Kleinmaßnahmen Landesgesellschaft Logistik'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_NW'  THEN 'Neubau "weitere Immobilien"'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_TG'  THEN 'Konzessionärsmaßnahme BERI'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_VK'  THEN 'Kleinmaßnahmen Landesgesellschaft Verwaltung'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_WR'  THEN 'Maßnahmen an "weiteren Immobilien"'
   WHEN v01.rpm_projekt_typ_id = 'ZPPM_MM'  THEN 'Marktmodernisierung'
   ELSE 'Sonstige Maßnahmenart'  END AS rpm_massnahmenart_bez

   FROM dbp_view.v_l_rpm_phase_2  v01
   WHERE SUBSTR( rpm_projekt_typ_id, 1, 4) = 'ZPPM';