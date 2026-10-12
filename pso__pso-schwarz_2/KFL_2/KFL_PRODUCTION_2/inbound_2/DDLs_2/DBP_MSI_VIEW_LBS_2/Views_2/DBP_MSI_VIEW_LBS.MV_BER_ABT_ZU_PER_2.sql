CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_BER_ABT_ZU_PER_2(
	ABT_ID,
	BER_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ARTHIERTYP_ID
) AS SELECT
    v01.wg_hierarchie_id AS abt_id,
    v01.wg_hierarchie_mutter_id AS ber_id,
    v01.mandant_id,
    v01.dat_von,
    v01.dat_bis,
    v01.arthiertyp_id
FROM dbp_view.v_wg_hierarchie_zu_per_2 v01
INNER JOIN dbp_view.v_abt_2 v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.wg_hierarchie_id = v02.abt_id
WHERE v01.arthiertyp_id = 10
    AND v01.wg_hierarchie_ebene_id = 2
    AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;