create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_OCR_EINGANGSKANAL_1(
	MANDANT_ID,
	OCR_EINGANGSKANAL_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 27.07.2017 twie: SPEC0017957 Lookup für neues Attribut

             SELECT
             mandant_id,
             ocr_eingangskanal_id
             FROM dbp_view.v_l_ocr_eingangskanal_1
             WHERE mandant_id = 1
;
