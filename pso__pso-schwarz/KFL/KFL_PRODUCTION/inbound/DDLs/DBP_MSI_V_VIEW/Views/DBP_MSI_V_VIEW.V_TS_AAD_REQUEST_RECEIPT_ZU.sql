CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_AAD_REQUEST_RECEIPT_ZU AS 
    SELECT 
        bon_id,
        bon_dat,
        wup_id,
        mandant_id,
        aad_request_id

FROM DBP_MSI_DATA.TS_AAD_REQUEST_RECEIPT_ZU ;