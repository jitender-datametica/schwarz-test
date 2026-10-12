CREATE OR REPLACE VIEW DBP_VIEW.V_BESCH_LIEF_KUERZUNG_1 AS 
    SELECT 
        mandant_id,
        dat_lief_soll,
        best_beleg_id,
        best_beleg_pos_id,
        menge_best_bme,
        menge_lief_bme,
        ek_netto_bnk_soll,
        ek_netto_bnk_ist,
        vk_netto_ist,
        vk_netto_soll,
        menge_best_kolli,
        menge_lief_kolli,
        wrg_id,
        quelle,
        versandstelle_id,
        art_id

FROM DBP_DATA.BESCH_LIEF_KUERZUNG_1 ;