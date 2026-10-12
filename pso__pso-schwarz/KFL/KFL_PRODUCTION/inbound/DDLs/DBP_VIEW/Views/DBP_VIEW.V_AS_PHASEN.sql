CREATE OR REPLACE VIEW DBP_VIEW.V_AS_PHASEN AS 
    SELECT 
        mandant_id,
        wg_id,
        posten_kz_sap,
        wtag_phasenbeginn

FROM DBP_DATA.AS_PHASEN ;