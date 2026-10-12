CREATE OR REPLACE VIEW DBP_VIEW.V_IN_KOSTEN_PROGNOSE_2 AS 
    SELECT 
        mandant_id,
        in_projekt_id,
        psp_id,
        in_wg_id,
        kosten_prognose_version_id,
        betrag_kosten_prognose,
        betrag_mmk_prognose,
        betrag_zea_prognose,
        wrg_id,
        dat_kosten_prognose_version
FROM DBP_DATA.IN_KOSTEN_PROGNOSE_2 ;