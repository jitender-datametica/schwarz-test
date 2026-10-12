CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_BEREICH_ZU_PER_1(
	BER_ID,
	MANDANT_ID,
	ARTHIERTYP_ID
) AS SELECT
    v01.wg_hierarchie_mutter_id AS ber_id,
    v01.mandant_id,
    v01.arthiertyp_id
FROM dbp_view.v_wg_hierarchie_zu_per_1 v01    
WHERE v01.arthiertyp_id = 10
    AND v01.wg_hierarchie_ebene_id = 2
    AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;