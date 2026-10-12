CREATE OR REPLACE VIEW DBP_VIEW.V_LAGERBESTAND_ATP_PER_2 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat_von,
        dat_bis,
        menge_lgbest_frei,
        menge_lgbest_block_werbung,
        menge_lgbest_block_iwt,
        menge_lgbest_block_nwbs

FROM DBP_DATA.LAGERBESTAND_ATP_PER_2 ;