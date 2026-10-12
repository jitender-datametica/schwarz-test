CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_nachlieferung AS SELECT nachlieferung_request_id,
 gp_exp_name,
 mandant_id,
 wup_id,
 art_id,
 dat_start,
 anzahl_dateien,
 active_fg,
 ldap_user,
 gp_id,
 periodizitaet,
 datzeit_insert,
 datzeit_update
FROM kfl_production_dbp_msi_data.ts_nachlieferung;