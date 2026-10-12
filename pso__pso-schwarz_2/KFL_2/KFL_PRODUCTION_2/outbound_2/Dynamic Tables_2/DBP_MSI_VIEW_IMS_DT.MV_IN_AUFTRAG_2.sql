CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_auftrag_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  auftr.mandant_id AS mandant_id,
  auftr.auftrag_id AS auftrag_id,
  auftr.auftragsart_id AS auftragsart_id,
  COALESCE(auftr.techn_platz_id, '') AS techn_platz_id,
  CASE WHEN auftr.auftragsart_id = '4IHA' THEN obj.cs_auftrag_prio ELSE NULL END AS cs_auftrag_prio
FROM kfl_production_dbp_view.v_in_auftrag_2 AS auftr
LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_objekt_qual_2 AS obj
  ON auftr.auftrag_id = obj.auftrag_id AND auftr.mandant_id = obj.mandant_id;
