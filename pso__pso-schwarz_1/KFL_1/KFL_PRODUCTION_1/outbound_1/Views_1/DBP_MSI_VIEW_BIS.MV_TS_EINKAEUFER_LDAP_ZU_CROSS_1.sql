CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_ts_einkaeufer_ldap_zu_cross_1 (ma_ldap, mandant_id,
einkaeufer_grp_id, eigene_gruppe_fg, hat_einkaeufer_grp_fg, belegt_eigene_gruppe_fg) AS SELECT SUBSTR(UPPER(t3.ma_ldap)
   , 1, 2) || SUBSTR(LOWER(t3.ma_ldap), 3, 8) AS ma_ldap,
 t3.mandant_id,
 t3.einkaeufer_grp_id,
 COALESCE(V05.eigene_gruppe_fg, 0) AS eigene_gruppe_fg,
  CASE
  WHEN V05.einkaeufer_bis_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS hat_einkaeufer_grp_fg,
  CASE
  WHEN V06.eigene_gruppe_fg = 1
  THEN 1
  ELSE 0
  END AS belegt_eigene_gruppe_fg
FROM (SELECT V01.ma_ldap,
   t2.mandant_id,
   t2.einkaeufer_grp_id
  FROM kfl_production_dbp_security.l_bis_ldap_1 AS V01
   INNER JOIN (SELECT 99 AS mandant_id,
      einkaeufer_int_id AS einkaeufer_grp_id
     FROM kfl_production_dbp_view.v_in_l_einkaeufer_int_1 AS V02
     UNION DISTINCT
     SELECT mandant_id,
      einkaeufer_grp_id
     FROM kfl_production_dbp_view.v_in_l_einkaeufer_grp_1 AS V03
     WHERE aktiv_fg = 1
      AND einkaeufer_grp_id <> '-1'
      AND (mandant_id <> 1 OR mandant_id = 1 AND SUBSTR(einkaeufer_grp_id, 1, 1) = 'S')) AS t2 ON TRUE) AS t3
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_1 AS V04 ON t3.ma_ldap = V04.user_id
 LEFT JOIN kfl_production_dbp_security.bis_einkaeufer_ldap_zu_1 AS V05 ON t3.mandant_id = V05.mandant_id AND t3.ma_ldap =
    V05.ma_ldap AND t3.einkaeufer_grp_id = V05.einkaeufer_bis_id
 LEFT JOIN kfl_production_dbp_security.bis_einkaeufer_ldap_zu_1 AS V06 ON t3.mandant_id = V06.mandant_id AND t3.ma_ldap <>
    V06.ma_ldap AND t3.einkaeufer_grp_id = V06.einkaeufer_bis_id;