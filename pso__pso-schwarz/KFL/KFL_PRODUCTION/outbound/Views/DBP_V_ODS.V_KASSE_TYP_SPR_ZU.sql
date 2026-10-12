CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_kasse_typ_spr_zu AS SELECT kasse_typ_id,
 spr_id,
 kasse_typ_bez,
 kasse_name_bez
FROM kfl_production_dbp_ods.kasse_typ_spr_zu;