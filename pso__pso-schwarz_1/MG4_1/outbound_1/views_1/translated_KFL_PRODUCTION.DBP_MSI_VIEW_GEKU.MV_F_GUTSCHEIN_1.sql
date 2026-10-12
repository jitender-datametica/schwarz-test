-- 11.02.2016 twie: Gutscheine vom Gutscheinserver
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_f_gutschein_1 (gutschein_id
, mandant_id, ausgeber_id, kostenstelle_id, zeitstempel, dat, uhrzeit, betrag_gutschein, wrg_id, geku_ticket_id) AS
SELECT gutschein_id,
 mandant_id,
 ausgeber_id,
 kostenstelle_id,
 zeitstempel,
 CAST(zeitstempel AS STRING) AS dat,
 CAST(zeitstempel AS TIME) AS uhrzeit,
 betrag_gutschein,
 wrg_id,
 geku_ticket_id
FROM kfl_production_dbp_view.v_gutschein_1 AS v01
WHERE transaktion_id = 4 -- aktivierte Gutscheine
 -- nur GEKU Gutscheine
 AND ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';