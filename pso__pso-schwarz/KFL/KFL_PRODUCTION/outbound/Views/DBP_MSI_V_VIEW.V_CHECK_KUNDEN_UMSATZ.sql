CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_check_kunden_umsatz AS SELECT dat,
 mandant_id,
 wup_id,
 kassierer_nr,
 kasse_nr,
 anz_bon_sap,
 umsatz_wrg,
 umsatz_brutto_gesamt,
 umsatz_netto_gesamt,
 umsatz_brutto_kasse
FROM kfl_production_dbp_msi_data.check_kunden_umsatz;