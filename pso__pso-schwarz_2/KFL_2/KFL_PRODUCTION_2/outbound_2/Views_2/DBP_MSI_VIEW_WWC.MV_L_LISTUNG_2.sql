CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_listung_2 AS SELECT CASE
  WHEN akt_mo = - 3
  THEN 1
  WHEN akt_mo = - 2
  THEN 2
  WHEN akt_mo = - 1
  THEN 3
  WHEN akt_mo = 0
  THEN 4
  ELSE NULL
  END AS listungs_kz,
  CASE
  WHEN akt_mo = - 3
  THEN '1'
  WHEN akt_mo = - 2
  THEN '0'
  WHEN akt_mo = - 1
  THEN 'X'
  WHEN akt_mo = 0
  THEN '-'
  ELSE NULL
  END AS listungs_kbez,
  CASE
  WHEN akt_mo = - 3
  THEN 'gelistet'
  WHEN akt_mo = - 2
  THEN 'wird gelistet'
  WHEN akt_mo = - 1
  THEN 'ausgelistet'
  WHEN akt_mo = 0
  THEN 'keine Listung'
  ELSE NULL
  END AS listungs_bez
FROM kfl_production_dbp_view.v_monat_2
WHERE akt_mo BETWEEN - 3 AND 0;