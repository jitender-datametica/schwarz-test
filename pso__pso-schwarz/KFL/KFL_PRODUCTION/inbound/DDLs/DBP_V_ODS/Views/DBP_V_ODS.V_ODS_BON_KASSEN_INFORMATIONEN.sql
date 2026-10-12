CREATE OR REPLACE VIEW DBP_V_ODS.V_ODS_BON_KASSEN_INFORMATIONEN AS 
    SELECT 
        bon_id
        ,wup_id
        ,mandant_id
        ,bon_dat
        ,kasse_name
        ,kassen_untertyp
        ,bargeld_abwicklung
        ,umsatz_brutto
        ,bonanzahl
        ,waage_aktiv_fg
FROM DBP_ODS.ods_bon_kassen_informationen ;