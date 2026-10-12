create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_F_GUTSCHEIN_1(
	CRM_GUTSCHEIN_ID,
	CRM_VORGANG_ID,
	CRM_GUTSCHEIN_GRUND_ID,
	GUTSCHEIN_NUMMER,
	KOSTENSTELLE_ID,
	MANDANT_ID,
	GUTSCHEIN_WERT,
	DAT_START,
	DAT_ENDE,
	DAT_START_PROCESSING,
	DAT_END_PROCESSING,
	SEC_KZ
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.crm_gutschein_id
   ,v01.crm_vorgang_id
   ,v01.crm_gutschein_grund_id
   ,v01.gutschein_nummer
   ,v01.kostenstelle_id
   ,v01.mandant_id
   ,v01.gutschein_wert
   ,TO_DATE(v02.dat_start) AS dat_start
   ,TO_DATE(v02.dat_ende) AS dat_ende
   ,TO_DATE(v02.dat_start_processing) AS dat_start_processing
   ,TO_DATE(v02.dat_end_processing) AS dat_end_processing
   ,3::BYTEINT AS sec_kz

   FROM DBP_DATA.CRM_GUTSCHEIN_1 v01
   INNER JOIN DBP_DATA.CRM_VORGANG_1 v02
   ON v01.crm_vorgang_id = v02.crm_vorgang_id
   WHERE v01.gutschein_nummer <> -1 AND v01.gutschein_nummer IS NOT NULL;
