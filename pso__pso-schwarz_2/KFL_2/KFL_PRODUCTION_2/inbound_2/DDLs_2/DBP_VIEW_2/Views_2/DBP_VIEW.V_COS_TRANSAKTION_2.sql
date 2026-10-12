CREATE OR REPLACE VIEW DBP_VIEW.V_COS_TRANSAKTION_2 AS 
    SELECT 
        bonuspunkte_transaktion_id,
        wrg_id,
        mandant_id,
        wup_id,
        umsatz_brutto,
        bon_dat,
        bon_barcode,
        bon_nr,
        umsatz_brutto_loyalty

FROM DBP_DATA.COS_TRANSAKTION_2 ;