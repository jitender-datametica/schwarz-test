CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_wup_tag_stunde_1 (mandant_id, wup_id, nb_id, wup_bereich_id
, wup_abt_id, ssm_cluster_id, ssm_prozess_id, dat, zeit_stunde, zeit_15min, ssm_aufwand_typ_id, wert, wert_gerundet) AS
SELECT WTS.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 WTS.nb_id,
 WTS.wup_bereich_id,
 WTS.wup_abt_id,
 WTS.ssm_cluster_id,
 WTS.ssm_prozess_id,
 WTS.dat,
 WTS.zeit_stunde,
 WTS.zeit_15min,
 WTS.ssm_aufwand_typ_id,
 WTS.wert,
 WTS.wert_gerundet
FROM kfl_production_dbp_view.v_ssm_wup_tag_stunde_1 AS WTS
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON WTS.mandant_id = WUP.mandant_id AND WTS.wup_id = WUP.wup_id;