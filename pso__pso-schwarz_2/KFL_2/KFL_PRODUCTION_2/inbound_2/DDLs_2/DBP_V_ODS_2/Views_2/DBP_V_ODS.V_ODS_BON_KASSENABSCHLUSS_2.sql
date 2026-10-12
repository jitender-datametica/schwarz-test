CREATE OR REPLACE VIEW DBP_V_ODS.V_ODS_BON_KASSENABSCHLUSS_2 AS 
    SELECT 
        mandant_id,
        bon_id,
        wup_id,
        bon_dat,
        umsatz_brutto,
        anz_kunden,
        anz_kunden_imbiss,
        anz_scans,
        sum_scan_sek
FROM DBP_ODS.ODS_BON_KASSENABSCHLUSS_2 ;