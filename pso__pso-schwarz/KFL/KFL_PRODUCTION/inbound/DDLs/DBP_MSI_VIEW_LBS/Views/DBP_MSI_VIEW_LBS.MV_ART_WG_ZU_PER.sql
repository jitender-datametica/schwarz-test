CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ART_WG_ZU_PER(
	MANDANT_ID,
	ART_ID,
	WG_ID,
	WUG_ID,
	ARTHIERTYP_ID
) AS SELECT
    mandant_id,
    v01.art_id,
    v01.wg_id,
    v01.wug_id,
    v01.arthiertyp_id
FROM dbp_view.v_art_wg_zu_per v01
WHERE v01.arthiertyp_id = 2
AND v01.dat_bis = '9999-12-31';