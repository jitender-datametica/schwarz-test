CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_scans_pro_minute AS SELECT scans_pro_minute.mandant_id,
 scans_pro_minute.wup_id,
 scans_pro_minute.nb_id,
 scans_pro_minute.kassierer_nr,
 scans_pro_minute.kjwo,
 scans_pro_minute.dat,
 scans_pro_minute.anz_artikel,
 scans_pro_minute.registrierzeit,
 scans_pro_minute.scans_pro_minute,
 scans_pro_minute.gew_durchschnitt,
 scans_pro_minute.td_insert,
 scans_pro_minute.td_update
FROM kfl_production_dbp_ods.scans_pro_minute AS scans_pro_minute;