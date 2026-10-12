CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_abschoepfung_wup (mandant_id, nb_id, wup_id, dat,
offen, wrg_id, betrag_markt_vor_geldabhlg, betrag_geldabhlg, betrag_markt_nach_geldabhlg, betrag_tresor_nach_geldabhlg,
betrag_schieb_nach_geldabhlg, quote_geldabhlg, betrag_geldabholg_90_prozent, betrag_diff_90_prozent) AS SELECT V01.mandant_id
 ,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.dat,
 V01.offen,
 COALESCE(V03.wrg_id, 'EUR') AS wrg_id,
 V03.betrag_markt_vor_geldabhlg,
 V03.betrag_geldabhlg,
 V03.betrag_markt_nach_geldabhlg,
 V03.betrag_tresor_nach_geldabhlg,
 V03.betrag_schieb_nach_geldabhlg,
 V03.quote_geldabhlg,
 V03.betrag_geldabholg_90_prozent,
 V03.betrag_diff_90_prozent
FROM kfl_production_dbp_view.v_wupcal AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = V02.dat
 LEFT JOIN kfl_production_dbp_view.v_wup_abschoepfung AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id
     AND V01.dat = V03.dat
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
WHERE V01.mandant_id = 1
 AND V01.nb_id = 0
 AND V02.akt_gj BETWEEN - 1 AND 0
 AND V02.akt_tag <= 0;