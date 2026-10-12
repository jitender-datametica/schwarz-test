CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_typ_spr_zu_1 (mandant_id, spr_id, angebot_typ_cd,
angebot_typ_bez) AS SELECT mandant_id,
 spr_id,
 angebot_typ_cd,
 angebot_typ_bez
FROM kfl_production_dbp_data.angebot_typ_spr_zu_1
WHERE spr_id = 22;