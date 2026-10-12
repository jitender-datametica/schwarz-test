CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_f_gutschein AS SELECT gutschein_id,
 mandant_id,
 ausgeber_id,
 kostenstelle_id,
 zeitstempel,
 CAST(zeitstempel AS STRING) AS dat,
 CAST(zeitstempel AS TIME) AS uhrzeit,
 betrag_gutschein,
 wrg_id,
 geku_ticket_id
FROM kfl_production_dbp_view.v_gutschein AS V01
WHERE transaktion_id = 4 AND ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';