CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_konzessionaer_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v0.partner_id AS konzessionaer_id,
  v0.partner_id AS partner_id,
  v0.verbund_kz AS verbund_kz,
  MAX(v0.vorname) AS name1,
  MAX(v0.nachname) AS name2,
  CASE
    WHEN MAX(v0.nachname) IS NULL
    THEN MAX(v0.vorname)
    ELSE MAX(v0.vorname) || ' ' || MAX(v0.nachname)
  END AS konzessionaer_bez,
  CASE
    WHEN v0.plz IS NULL OR v0.plz = ''
    THEN v0.plz || ' ' || v0.ort || ' ' || v0.strasse || ' ' || v0.haus_nr
    ELSE v0.plz || ' ' || v0.ort || ',' || '' || ' ' || v0.strasse || ' ' || v0.haus_nr
  END AS konz_adresse
FROM kfl_production_dbp_view.v_immo_l_partner_2 AS v0
INNER JOIN kfl_production_dbp_view.v_immo_mv_partner_rolle_zu_2 AS v1
  ON v0.partner_id = v1.partner_id
GROUP BY
  konzessionaer_id,
  v0.partner_id,
  v0.verbund_kz,
  konz_adresse
UNION ALL
SELECT DISTINCT
  '' AS konzessionaer_id,
  '' AS partner_id,
  '' AS name1,
  '' AS name2,
  '' AS konzessionaer_bez,
  '' AS verbund_kz,
  '' AS konz_adresse
FROM kfl_production_dbp_view.v_mandant_2;
