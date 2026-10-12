CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WG_PER_1(
	MANDANT_ID,
	WG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID_LANG,
	OWG_ID
) AS SELECT
    v01.mandant_id,
    v01.wg_id,
    v01.arthiertyp_id,
    v01.abt_id,
    CASE WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
    ELSE TO_VARCHAR(v01.wg_id, 'FM000') END AS wg_id_lang,
    v01.owg_id
FROM dbp_view.v_wg_per_1 v01
WHERE v01.dat_bis = '9999-12-31';