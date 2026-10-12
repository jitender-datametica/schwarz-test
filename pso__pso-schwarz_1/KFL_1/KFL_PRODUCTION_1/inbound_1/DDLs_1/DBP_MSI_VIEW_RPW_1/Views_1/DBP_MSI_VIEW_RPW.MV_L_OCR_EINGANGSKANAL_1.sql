CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_OCR_EINGANGSKANAL_1
          -- 27.07.2017 twie: SPEC0017957 Lookup für neues Attribut

          (
          mandant_id
          ,ocr_eingangskanal_id
          )
          AS
             SELECT
             mandant_id,
             ocr_eingangskanal_id
             FROM dbp_view.v_l_ocr_eingangskanal_1
             WHERE mandant_id = 1
 ;