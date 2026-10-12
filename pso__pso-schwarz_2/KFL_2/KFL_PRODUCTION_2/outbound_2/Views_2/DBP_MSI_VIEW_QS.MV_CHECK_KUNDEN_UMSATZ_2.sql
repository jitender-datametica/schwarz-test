CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_check_kunden_umsatz_2 (dat, mandant_id, wup_id, nb_id,
anz_bon_sap, umsatz_brutto_gesamt, umsatz_netto_gesamt, umsatz_brutto_kasse) AS SELECT V01.dat,
 V01.mandant_id,
 V01.wup_id,
 V02.nb_id,
 SUM(V01.anz_bon_sap) AS anz_bon_sap,
 SUM(V01.umsatz_brutto_gesamt) AS umsatz_brutto_gesamt,
 SUM(V01.umsatz_netto_gesamt) AS umsatz_netto_gesamt,
 SUM(V01.umsatz_brutto_kasse) AS umsatz_brutto_kasse
FROM kfl_production_dbp_msi_v_view.v_check_kunden_umsatz_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id
GROUP BY V01.dat,
 V01.mandant_id,
 V01.wup_id,
 V02.nb_id;