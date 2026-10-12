CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_KJMO_SPR_ZU_1(
	KJMO,
	SPR_ID,
	KJMO_BEZ,
	KJMO_BEZ_LANG,
	GJMO
) AS SELECT
    kjmo,
    spr_id,
    kjmo_bez,
    kjmo_bez_lang,
    gjmo
FROM dbp_view.v_kjmo_spr_zu_1;