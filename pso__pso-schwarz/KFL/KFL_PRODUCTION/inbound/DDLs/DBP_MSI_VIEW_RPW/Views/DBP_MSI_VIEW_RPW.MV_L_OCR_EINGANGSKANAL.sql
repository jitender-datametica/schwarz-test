CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_OCR_EINGANGSKANAL
          -- 27.07.2017 twie: SPEC0017957 Lookup für neues Attribut

          (
          mandant_id
          ,ocr_eingangskanal_id
          )
          AS
             SELECT
             mandant_id,
             ocr_eingangskanal_id
             FROM dbp_view.v_l_ocr_eingangskanal
             WHERE mandant_id = 1
 ;