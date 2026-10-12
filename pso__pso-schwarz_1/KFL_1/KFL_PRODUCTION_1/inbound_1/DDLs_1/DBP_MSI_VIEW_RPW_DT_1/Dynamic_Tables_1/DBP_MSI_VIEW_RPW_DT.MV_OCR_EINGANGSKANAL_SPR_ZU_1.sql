create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_OCR_EINGANGSKANAL_SPR_ZU_1(
	MANDANT_ID,
	OCR_EINGANGSKANAL_ID,
	OCR_EINGANGSKANAL_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 27.07.2017 twie: SPEC0017957 Sprachzu für neues Attribut

                      SELECT
                      mandant_id,
                      ocr_eingangskanal_id,
                      ocr_eingangskanal_bez
                      FROM dbp_view.v_ocr_eingangskanal_spr_zu_1
                      WHERE spr_id = 22
                      AND mandant_id = 1
 ;
