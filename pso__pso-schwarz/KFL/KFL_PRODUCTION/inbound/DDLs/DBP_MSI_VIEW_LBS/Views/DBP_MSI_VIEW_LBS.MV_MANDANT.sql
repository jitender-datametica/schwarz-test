CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_MANDANT(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ
) AS SELECT
    mandant_id,
    mandant_bez,
    mandant_kbez
FROM dbp_view.v_mandant;