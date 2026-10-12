-- 04.08.2022 twie: SPEC0164822 M:N Zuordnung zwischen CRM Vorgang und Fremdkoerper

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_crm_vorgang_fremdkoerper_zu (crm_vorgang_id,
crm_fremdkoerper_id) AS SELECT crm_vorgang_id,
 crm_fremdkoerper_id
FROM kfl_production_dbp_view.v_crm_vorgang_fremdkoerper_zu;