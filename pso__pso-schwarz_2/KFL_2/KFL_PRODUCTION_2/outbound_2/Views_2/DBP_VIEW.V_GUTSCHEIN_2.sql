CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gutschein_2 AS SELECT gutschein_id,
 mandant_id,
 transaktion_id,
 zeitstempel,
 system_id,
 profil_id,
 wrg_id,
 ausgeber_typ_id,
 betrag_gutschein,
 ausgeber_id,
 kostenstelle_id,
 ereignisquelle_id,
 geku_ticket_id
FROM kfl_production_dbp_data.gutschein_2;