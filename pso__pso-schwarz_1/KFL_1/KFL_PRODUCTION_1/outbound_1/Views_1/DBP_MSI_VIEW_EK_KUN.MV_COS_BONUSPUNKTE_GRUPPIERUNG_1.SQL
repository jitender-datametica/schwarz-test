CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_bonuspunkte_gruppierung_1 (crm_konto_id, mandant_id,
bonuspunkt_fg, anz_bonuspunkte, anz_bonuspunkte_gruppierung) AS SELECT crm_konto_id,
 mandant_id,
 bonuspunkt_fg,
 anz_bonuspunkte,
  CASE
  WHEN anz_bonuspunkte BETWEEN 0 AND 9 AND bonuspunkt_fg >= 1
  THEN '0 - 9'
  WHEN anz_bonuspunkte BETWEEN 10 AND 19 AND bonuspunkt_fg >= 1
  THEN '10 - 19'
  WHEN anz_bonuspunkte BETWEEN 20 AND 29 AND bonuspunkt_fg >= 1
  THEN '20 - 29'
  WHEN anz_bonuspunkte BETWEEN 30 AND 39 AND bonuspunkt_fg >= 1
  THEN '30 - 39'
  WHEN anz_bonuspunkte BETWEEN 40 AND 49 AND bonuspunkt_fg >= 1
  THEN '40 - 49'
  WHEN anz_bonuspunkte BETWEEN 50 AND 59 AND bonuspunkt_fg >= 1
  THEN '50 - 59'
  WHEN anz_bonuspunkte BETWEEN 60 AND 69 AND bonuspunkt_fg >= 1
  THEN '60 - 69'
  WHEN anz_bonuspunkte BETWEEN 70 AND 79 AND bonuspunkt_fg >= 1
  THEN '70 - 79'
  WHEN anz_bonuspunkte BETWEEN 80 AND 89 AND bonuspunkt_fg >= 1
  THEN '80 - 89'
  WHEN anz_bonuspunkte BETWEEN 90 AND 99 AND bonuspunkt_fg >= 1
  THEN '90 - 99'
  WHEN anz_bonuspunkte BETWEEN 100 AND 109 AND bonuspunkt_fg >= 1
  THEN '100 - 109'
  WHEN anz_bonuspunkte BETWEEN 110 AND 119 AND bonuspunkt_fg >= 1
  THEN '110 - 119'
  WHEN anz_bonuspunkte BETWEEN 120 AND 129 AND bonuspunkt_fg >= 1
  THEN '120 - 129'
  WHEN anz_bonuspunkte BETWEEN 130 AND 139 AND bonuspunkt_fg >= 1
  THEN '130 - 139'
  WHEN anz_bonuspunkte BETWEEN 140 AND 149 AND bonuspunkt_fg >= 1
  THEN '140 - 149'
  WHEN anz_bonuspunkte BETWEEN 150 AND 159 AND bonuspunkt_fg >= 1
  THEN '150 - 159'
  WHEN anz_bonuspunkte BETWEEN 160 AND 169 AND bonuspunkt_fg >= 1
  THEN '160 - 169'
  WHEN anz_bonuspunkte BETWEEN 170 AND 179 AND bonuspunkt_fg >= 1
  THEN '170 - 179'
  WHEN anz_bonuspunkte BETWEEN 180 AND 189 AND bonuspunkt_fg >= 1
  THEN '180 - 189'
  WHEN anz_bonuspunkte BETWEEN 190 AND 199 AND bonuspunkt_fg >= 1
  THEN '190 - 199'
  WHEN anz_bonuspunkte BETWEEN 200 AND 249 AND bonuspunkt_fg >= 1
  THEN '200 - 249'
  WHEN anz_bonuspunkte BETWEEN 250 AND 299 AND bonuspunkt_fg >= 1
  THEN '250 - 299'
  WHEN anz_bonuspunkte BETWEEN 300 AND 349 AND bonuspunkt_fg >= 1
  THEN '300 - 349'
  WHEN anz_bonuspunkte BETWEEN 350 AND 399 AND bonuspunkt_fg >= 1
  THEN '350 - 399'
  WHEN anz_bonuspunkte BETWEEN 400 AND 449 AND bonuspunkt_fg >= 1
  THEN '400 - 449'
  WHEN anz_bonuspunkte BETWEEN 450 AND 499 AND bonuspunkt_fg >= 1
  THEN '450 - 499'
  WHEN anz_bonuspunkte BETWEEN 500 AND 599 AND bonuspunkt_fg >= 1
  THEN '500 - 599'
  WHEN anz_bonuspunkte BETWEEN 600 AND 699 AND bonuspunkt_fg >= 1
  THEN '600 - 699'
  WHEN anz_bonuspunkte BETWEEN 700 AND 799 AND bonuspunkt_fg >= 1
  THEN '700 - 799'
  WHEN anz_bonuspunkte BETWEEN 800 AND 899 AND bonuspunkt_fg >= 1
  THEN '800 - 899'
  WHEN anz_bonuspunkte BETWEEN 900 AND 999 AND bonuspunkt_fg >= 1
  THEN '900 - 999'
  WHEN anz_bonuspunkte BETWEEN 1000 AND 1199 AND bonuspunkt_fg >= 1
  THEN '1000 - 1199'
  WHEN anz_bonuspunkte BETWEEN 1200 AND 1399 AND bonuspunkt_fg >= 1
  THEN '1200 - 1399'
  WHEN anz_bonuspunkte BETWEEN 1400 AND 1599 AND bonuspunkt_fg >= 1
  THEN '1400 - 1599'
  WHEN anz_bonuspunkte BETWEEN 1600 AND 1799 AND bonuspunkt_fg = 1
  THEN '1600 - 1799'
  WHEN anz_bonuspunkte BETWEEN 1800 AND 1999 AND bonuspunkt_fg = 1
  THEN '1800 - 1999'
  WHEN anz_bonuspunkte > 1999 AND bonuspunkt_fg = 1
  THEN '> 1999'
  ELSE NULL
  END AS anz_bonuspunkte_gruppierung
FROM (SELECT crm_konto_id,
   mandant_id,
    CASE
    WHEN dat_verfall_bonuspunkte >= CURRENT_DATE
    THEN 1
    ELSE 0
    END AS bonuspunkt_fg,
   SUM(anz_bonuspunkte) AS anz_bonuspunkte
  FROM kfl_production_dbp_view.v_cos_bonuspunkte_1
  WHERE CASE
     WHEN dat_verfall_bonuspunkte >= CURRENT_DATE
     THEN 1
     ELSE 0
     END = 1
  GROUP BY crm_konto_id,
   mandant_id,
   bonuspunkt_fg) AS t1_1;