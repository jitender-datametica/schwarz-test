CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_artkz_posten_sap_spr_zu_1 (mandant_id, posten_kz_sap,
posten_bez_sap, posten_bez_sap_de, posten_bez_sap_cz, posten_bez_sap_sk, posten_bez_sap_hr, posten_bez_sap_pl,
posten_bez_sap_ro, posten_bez_sap_bg) AS (SELECT mandant_id,
  posten_kz_sap,
  COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez_sap
     ELSE NULL
     END), 'nicht gepflegt') AS posten_bez_sap,
  COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez_sap
     ELSE NULL
     END), 'nicht gepflegt') AS posten_bez_sap_de,
  COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN posten_bez_sap
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 22
      THEN posten_bez_sap
      ELSE NULL
      END), 'nicht gepflegt')) AS posten_bez_sap_cz,
  COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN posten_bez_sap
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 22
      THEN posten_bez_sap
      ELSE NULL
      END), 'nicht gepflegt')) AS posten_bez_sap_sk,
  COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN posten_bez_sap
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 22
      THEN posten_bez_sap
      ELSE NULL
      END), 'nicht gepflegt')) AS posten_bez_sap_hr,
  COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN posten_bez_sap
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 22
      THEN posten_bez_sap
      ELSE NULL
      END), 'nicht gepflegt')) AS posten_bez_sap_pl,
  COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN posten_bez_sap
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 22
      THEN posten_bez_sap
      ELSE NULL
      END), 'nicht gepflegt')) AS posten_bez_sap_ro,
  COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN posten_bez_sap
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 22
      THEN posten_bez_sap
      ELSE NULL
      END), 'nicht gepflegt')) AS posten_bez_sap_bg
 FROM kfl_production_dbp_view.v_posten_kz_sap_spr_zu_1 AS V01
 GROUP BY mandant_id,
  posten_kz_sap
 UNION DISTINCT
 SELECT mandant_id,
  posten_id AS posten_kz_sap,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'nicht gepflegt'
    END) AS posten_bez_sap,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'nicht gepflegt'
    END) AS posten_bez_sap_de,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'Posten není nastaven'
    END) AS posten_bez_sap_cz,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'Posten nie je nastaven\u00fd'
    END) AS posten_bez_sap_sk,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'Posten nije postavljeno'
    END) AS posten_bez_sap_hr,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'Posten nie jest ustawione'
    END) AS posten_bez_sap_pl,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE 'Posten nu este setat'
    END) AS posten_bez_sap_ro,
  MAX(CASE
    WHEN posten_id <> ''
    THEN posten_bez
    ELSE CONCAT('->->-> ->->->->', ' Posten')
    END) AS posten_bez_sap_bg
 FROM kfl_production_dbp_view.v_artkz_posten_1 AS V01
 WHERE mandant_id = 1
 GROUP BY mandant_id,
  posten_kz_sap)
UNION DISTINCT
SELECT mandant_id,
 '' AS posten_kz_sap,
 'nicht gepflegt' AS posten_bez_sap,
 'nicht gepflegt' AS posten_bez_sap_de,
 'Posten není nastaven' AS posten_bez_sap_cz,
 'Posten nie je nastaven\u00fd' AS posten_bez_sap_sk,
 'Posten nije postavljeno' AS posten_bez_sap_hr,
 'Posten nie jest ustawione' AS posten_bez_sap_pl,
 'Posten nu este setat' AS posten_bez_sap_ro,
 CONCAT('->->-> ->->->->', ' Posten') AS posten_bez_sap_bg
FROM kfl_production_dbp_view.v_mandant_1 AS V01
WHERE mandant_id <> 1;