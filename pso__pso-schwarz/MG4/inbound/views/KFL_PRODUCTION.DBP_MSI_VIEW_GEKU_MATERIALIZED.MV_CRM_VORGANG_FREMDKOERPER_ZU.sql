create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_CRM_VORGANG_FREMDKOERPER_ZU(
	CRM_VORGANG_ID,
	CRM_FREMDKOERPER_ID
) as
-- 04.08.2022 twie: SPEC0164822 M:N Zuordnung zwischen CRM Vorgang und Fremdkoerper

   SELECT

   crm_vorgang_id
   ,crm_fremdkoerper_id

   FROM dbp_view.v_crm_vorgang_fremdkoerper_zu;