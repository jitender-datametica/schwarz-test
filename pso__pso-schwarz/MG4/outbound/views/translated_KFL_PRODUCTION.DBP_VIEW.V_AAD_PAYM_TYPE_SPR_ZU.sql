CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_paym_type_spr_zu (mandant_id, spr_id, kpos_zahlung_typ_id,
kpos_zahlung_typ_bez, paym_type_name) AS SELECT mandant_id,
 spr_id,
 kpos_zahlung_typ_id,
 kpos_zahlung_typ_bez,
 paym_type_name
FROM kfl_production_dbp_data.aad_paym_type_spr_zu;