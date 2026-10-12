CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_wupcal_2 (mandant_id, wup_id, nb_id, dat, offen, werbewoche,
datenlieferung_artbew_wg_sum, bonanzahl, datenlieferung_bonanzahl, bonanzahl_misvier, datenlieferung_misvier,
datenlieferung_artbew, datenlieferung_qbm_status, bonanzahl_imbiss, pruef_status_id_umsatz, pruef_status_id_kunde,
pruef_grund_id_umsatz, pruef_grund_id_kunde, dat_extrakt_umsatz, offen_von, offen_bis, bonanzahl_sug,
bonanzahl_kundenkarte) AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 offen,
 werbewoche,
 datenlieferung_artbew_wg_sum,
 bonanzahl,
 datenlieferung_bonanzahl,
 bonanzahl_misvier,
 datenlieferung_misvier,
 datenlieferung_artbew,
 datenlieferung_qbm_status,
 bonanzahl_imbiss,
 pruef_status_id_umsatz,
 pruef_status_id_kunde,
 pruef_grund_id_umsatz,
 pruef_grund_id_kunde,
 dat_extrakt_umsatz,
 offen_von,
 offen_bis,
 bonanzahl_sug -- ,v01.umsatz_brutto_ods_verkauf
 -- fehlende Währungsumrechnung

 -- ,v01.umsatz_brutto_ods_kassenabschluss
,
 bonanzahl_kundenkarte
 -- Field bonanzahl_kundenkarte is not used as a fact in EK Kunde. This field also contains payback card in summation.

 -- The field shouldn't be used as a fact in EK Kunde, since it contains Payback

FROM kfl_production_dbp_view.v_wupcal_2 AS v01;