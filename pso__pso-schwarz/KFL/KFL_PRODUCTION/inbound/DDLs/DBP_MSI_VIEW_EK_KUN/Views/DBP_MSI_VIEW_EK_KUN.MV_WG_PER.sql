create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_WG_PER(
	WG_ID,
	ARTHIERTYP_ID,
	LEAD_MWST_ID,
	DAT_VON,
	ABT_ID,
	MANDANT_ID,
	DAT_BIS,
	OWG_ID
) as
  SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    wg_id
   ,arthiertyp_id
   ,lead_mwst_id
   ,dat_von
   ,abt_id
   ,mandant_id
   ,dat_bis
   ,owg_id

 FROM DBP_DATA.WG_PER
 WHERE arthiertyp_id = 2
 AND dat_bis > CURRENT_DATE;
