CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_ts_lief_ek_grp_int_zu_cross_2 (grp_mandant_id, einkaeufer_grp_id
, lief_mandant_id, in_lief_id, hat_lieferant_fg) AS SELECT t1.grp_mandant_id,
 COALESCE(t1.einkaeufer_grp_id, t2.einkaeufer_bis_id) AS einkaeufer_grp_id,
 t1.lief_mandant_id,
 t1.in_lief_id,
 t1.hat_lieferant_fg
FROM (SELECT 99 AS grp_mandant_id,
   V04.einkaeufer_int_id AS einkaeufer_grp_id,
   V01.mandant_id AS lief_mandant_id,
   V01.in_lief_id,
    CASE
    WHEN V04.in_lief_id IS NULL
    THEN 0
    ELSE 1
    END AS hat_lieferant_fg
  FROM kfl_production_dbp_view.v_in_lieferant_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_in_lieferant_ekorg_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.in_lief_id
       = V02.in_lief_id AND V02.einkaeufer_grp_id IS NOT NULL
   INNER JOIN kfl_production_dbp_view.v_in_l_ekorg_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.einkaufsorganisation_id
       = V03.einkaufsorganisation_id AND V03.sako_fg = 1
   LEFT JOIN kfl_production_dbp_msi_view_bis.ts_einkaeufer_int_lief_zu_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01
     .in_lief_id = V04.in_lief_id
   LEFT JOIN kfl_production_dbp_security.bis_einkaeufer_ldap_zu_2 AS V05 ON SUBSTR(CAST(V04.einkaeufer_int_id AS STRING),
     1, 10) = V05.einkaeufer_bis_id
   LEFT JOIN kfl_production_dbp_msi.akt_msi_user_2 AS V06 ON V05.ma_ldap = V06.user_id
  WHERE V05.mandant_id = 99 AND V05.eigene_gruppe_fg = 1 AND V06.user_id IS NOT NULL
   OR (V01.mandant_id, V01.in_lief_id) NOT IN (SELECT (mandant_id, in_lief_id)
     FROM kfl_production_dbp_msi_view_bis.ts_einkaeufer_int_lief_zu_2)
  QUALIFY (SUM(1) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.in_lief_id AS STRING) ORDER BY V02.einkaufsorganisation_id
        IS NULL, V02.einkaufsorganisation_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1) AS t1_2
 INNER JOIN (SELECT V07.einkaeufer_bis_id
  FROM kfl_production_dbp_security.bis_einkaeufer_ldap_zu_2 AS V07
   INNER JOIN kfl_production_dbp_msi.akt_msi_user_2 AS V08 ON V07.ma_ldap = V08.user_id
  WHERE V07.mandant_id = 99
   AND V07.eigene_gruppe_fg = 1
   AND V08.user_id IS NOT NULL) AS t2 ON TRUE
GROUP BY t1.grp_mandant_id,
 einkaeufer_grp_id,
 t1.lief_mandant_id,
 t1.in_lief_id,
 t1.hat_lieferant_fg;