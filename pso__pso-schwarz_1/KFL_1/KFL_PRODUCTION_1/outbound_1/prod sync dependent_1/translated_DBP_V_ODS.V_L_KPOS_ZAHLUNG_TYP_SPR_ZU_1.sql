CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_l_kpos_zahlung_typ_spr_zu_1 (kpos_zahlung_typ_id, mandant_id, spr_id,
kpos_zahlung_typ_bez) AS SELECT kpos_zahlung_typ_id,
 mandant_id,
 spr_id,
 kpos_zahlung_typ_bez
FROM kfl_production_dbp_ods.l_kpos_zahlung_typ_spr_zu_1;