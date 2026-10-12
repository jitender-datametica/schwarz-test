CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_kassenabschluss AS SELECT mandant_id,
 bon_id,
 wup_id,
 bon_dat,
 umsatz_brutto,
 anz_kunden,
 anz_kunden_imbiss,
 anz_scans,
 sum_scan_sek
FROM kfl_production_dbp_ods.ods_bon_kassenabschluss;