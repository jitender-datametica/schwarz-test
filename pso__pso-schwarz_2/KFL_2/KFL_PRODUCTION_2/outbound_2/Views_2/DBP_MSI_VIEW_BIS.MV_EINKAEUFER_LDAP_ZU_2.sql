CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_einkaeufer_ldap_zu_2 (ma_ldap, mandant_id, einkaeufer_grp_id,
eigene_gruppe_fg, hat_einkaeufer_grp_fg) AS SELECT SUBSTR(UPPER(V01.ma_ldap), 1, 2) || SUBSTR(LOWER(V01.ma_ldap), 3, 8)
 AS ma_ldap,
 t2.mandant_id,
 t2.einkaeufer_bis_id AS einkaeufer_grp_id,
 t2.eigene_gruppe_fg,
  CASE
  WHEN t2.ma_ldap IS NOT NULL
  THEN 1
  ELSE 0
  END AS hat_einkaeufer_grp_fg
FROM kfl_production_dbp_security.l_bis_ldap_2 AS V01
 LEFT JOIN (SELECT V02.ma_ldap,
   V02.mandant_id,
   V02.einkaeufer_bis_id,
   V02.eigene_gruppe_fg
  FROM kfl_production_dbp_security.bis_einkaeufer_ldap_zu_2 AS V02
   INNER JOIN (SELECT mandant_id,
      einkaeufer_grp_id
     FROM kfl_production_dbp_view.v_in_l_einkaeufer_grp_2 AS V03
     WHERE aktiv_fg = 1
      AND einkaeufer_grp_id <> '-1'
     UNION DISTINCT
     SELECT 99 AS mandant_id,
      einkaeufer_int_id AS einkaeufer_grp_id
     FROM kfl_production_dbp_view.v_in_l_einkaeufer_int_2 AS V04) AS t3 ON V02.mandant_id = t3.mandant_id AND V02.einkaeufer_bis_id
      = t3.einkaeufer_grp_id) AS t2 ON V01.ma_ldap = t2.ma_ldap;