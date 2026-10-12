CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_abschoepfung_1 AS SELECT wup_id,
 mandant_id,
 dat,
 nb_id,
 betrag_markt_vor_geldabhlg,
 betrag_geldabhlg,
 betrag_markt_nach_geldabhlg,
 betrag_tresor_nach_geldabhlg,
 betrag_schieb_nach_geldabhlg,
 betrag_geldabholg_90_prozent,
 betrag_diff_90_prozent,
 quote_geldabhlg,
 wrg_id
FROM kfl_production_dbp_data.wup_abschoepfung_1;