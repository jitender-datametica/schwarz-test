CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ABT_1(
	ABT_ID,
	MANDANT_ID,
	ARTHIERTYP_ID
) AS SELECT
    abt_id,
    mandant_id,
    arthiertyp_id
FROM dbp_view.v_abt_1;