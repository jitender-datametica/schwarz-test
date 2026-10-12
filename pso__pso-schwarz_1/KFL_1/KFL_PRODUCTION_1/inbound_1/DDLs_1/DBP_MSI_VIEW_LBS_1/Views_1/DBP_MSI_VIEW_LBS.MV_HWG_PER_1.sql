CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_HWG_PER_1(
	HWG_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ARTHIERTYP_ID,
	ABT_ID
) AS SELECT
    v01.hwg_id,
    v01.mandant_id,
    v01.dat_von,
    v01.dat_bis,
    v01.arthiertyp_id,
    v01.abt_id
FROM dbp_view.v_hwg_per_1 v01
WHERE v01.arthiertyp_id = 2
    AND v01.dat_bis = '9999-12-31';