CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_posten_sap_kz (mandant_id, posten_kz) AS SELECT
DISTINCT mandant_id,
 posten_id AS posten_kz
FROM kfl_production_dbp_view.v_artkz_posten AS V01
WHERE mandant_id <> 1
UNION ALL
SELECT DISTINCT mandant_id,
 ' ' AS posten_id
FROM kfl_production_dbp_view.v_artkz_posten AS V01
WHERE mandant_id <> 1;