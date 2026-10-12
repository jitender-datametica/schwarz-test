CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_els_leergut_kopf_2 AS SELECT barcode_leergut,
 mandant_id,
 wup_id,
 nb_id,
 bon_dat,
 wrg_id,
 bon_tmsp,
 bon_nr,
 system_bez,
 system_typ_bez,
 system_hersteller_bez,
 bon_wert
FROM kfl_production_dbp_ods.els_leergut_kopf_2;