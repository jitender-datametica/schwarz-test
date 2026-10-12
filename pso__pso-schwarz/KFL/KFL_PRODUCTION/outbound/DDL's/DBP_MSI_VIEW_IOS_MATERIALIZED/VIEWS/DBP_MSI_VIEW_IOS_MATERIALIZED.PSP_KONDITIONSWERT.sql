CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.psp_konditionswert (mandant_id, psp_id, wrg_id,
betrag_konditionswert_gebucht, betrag_konditionswert_ungebucht, konditionsart_id, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.psp_konditionswert;