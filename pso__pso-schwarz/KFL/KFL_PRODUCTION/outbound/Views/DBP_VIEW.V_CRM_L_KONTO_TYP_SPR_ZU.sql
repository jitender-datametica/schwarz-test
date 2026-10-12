CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_konto_typ_spr_zu AS SELECT crm_konto_typ_id,
 spr_id,
 crm_konto_typ_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_l_konto_typ_spr_zu;