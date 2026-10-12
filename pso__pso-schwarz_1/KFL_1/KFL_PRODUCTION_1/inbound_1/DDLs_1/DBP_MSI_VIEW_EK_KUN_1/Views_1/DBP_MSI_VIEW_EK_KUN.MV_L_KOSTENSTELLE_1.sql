create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_L_KOSTENSTELLE_1(
	KOSTENSTELLE_ID,
	MANDANT_ID,
	KOSTENSTELLE_BEZ,
	DAT_BIS
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    kostenstelle_id
   ,mandant_id
   ,kostenstelle_bez
   ,dat_bis

   FROM DBP_DATA.KOSTENSTELLE_PER_1
   -- Tabelle ist historisiert, immer nur den neuesten Eintrag pro Kostenstelle
   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1;
