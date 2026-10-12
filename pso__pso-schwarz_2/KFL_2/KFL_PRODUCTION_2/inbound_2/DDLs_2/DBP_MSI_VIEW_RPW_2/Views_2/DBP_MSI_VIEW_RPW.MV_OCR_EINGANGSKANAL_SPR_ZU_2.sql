CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_OCR_EINGANGSKANAL_SPR_ZU_2
                   -- 27.07.2017 twie: SPEC0017957 Sprachzu für neues Attribut

                   (
                   mandant_id
                   ,ocr_eingangskanal_id
                   ,ocr_eingangskanal_bez
                   )
                   AS
                      SELECT
                      mandant_id,
                      ocr_eingangskanal_id,
                      ocr_eingangskanal_bez
                      FROM dbp_view.v_ocr_eingangskanal_spr_zu_2
                      WHERE spr_id = 22
                      AND mandant_id = 1
 ;