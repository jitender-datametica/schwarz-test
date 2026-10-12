CREATE OR REPLACE VIEW DBP_VIEW.V_WEWA AS 
    SELECT 
        mandant_id,
        wewa_beleg_id,
        wewa_beleg_pos_id,
        wewa_jahr,
        art_id,
        wup_id,
        nb_id,
        gp_id,
        lager_bewart_id,
        dat_buch,
        menge_basis,
        betrag_ek_netto,
        status,
        wrg_id,
        betrag_vk_netto,
        konditionsbetrag_zar5
FROM DBP_DATA.WEWA ;