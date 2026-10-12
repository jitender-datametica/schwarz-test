CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_KOMMBEREICH_UNIQUE_1(
	KOMM_BEREICH
) AS
   SELECT DISTINCT
   CASE WHEN TRIM(COALESCE(komm_bereich,'')) <> '' THEN komm_bereich ELSE 'kein Kommbereich' END AS komm_bereich
   FROM dbp_view.v_l_lagerplatz_1;