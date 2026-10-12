-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

-- 10.05.2021 twie: SPEC0081686 Kombination aller user mit allen IT Projekten für Transaktion Zuordnungsbericht

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_user_it_projekt_zu_cross_2 (it_projekt_id, user_id
, sec_fg) AS SELECT V01.it_projekt_id,
 LOWER(v02.user_id) AS user_id,
  CASE
  WHEN V03.user_id IS NULL
  THEN 0
  ELSE 1
  END AS sec_fg
FROM kfl_production_dbp_view.v_it_projekt_2 AS V01
 INNER JOIN (SELECT user_id
  FROM kfl_production_dbp_security.l_msi_user_2
  WHERE msi_produkt_bez = 'IMS') AS v02 ON TRUE
 LEFT JOIN kfl_production_dbp_security.l_ims_user_it_projekt_2 AS V03 ON V01.it_projekt_id = V03.it_projekt_id AND v02.user_id
    = V03.user_id;