-- 25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

-- 29.09.2022 twie: SPEC0167837 Kombination aller User mit allen Mandanten für Transaktion Zuordnungsbericht

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_user_mandant_zu_cross (mandant_id, user_id,
sec_fg) AS SELECT V01.mandant_id,
 LOWER(v02.user_id) AS user_id,
  CASE
  WHEN V03.user_id IS NULL
  THEN 0
  ELSE 1
  END AS sec_fg
FROM dbp_view.v_mandant AS V01
 INNER JOIN (SELECT user_id
  FROM dbp_security.l_msi_user
  WHERE msi_produkt_bez = 'KMR') AS v02 ON TRUE
 LEFT JOIN dbp_security.user_mandant_msiprodukt_zu AS V03 ON V01.mandant_id = V03.mandant_id AND v02.user_id
     = V03.user_id AND V03.msi_produkt_bez = 'KMR';