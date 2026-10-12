CREATE OR REPLACE VIEW DBP_VIEW.V_ivs_debitor_kontostand AS 
    SELECT 
        debitor_id,
        abzug_id,
        mandant_id,
        kjmo,
        mietvertrag_id,
        wup_id,
        buchungskreis_id,
        wrg_id,
        sonderhauptbuch_id,
        summe_soll,
        summe_haben,
        saldo_vortrag,
        saldo_soll,
        saldo_haben,
        saldo_konto
FROM DBP_DATA.ivs_debitor_kontostand ;