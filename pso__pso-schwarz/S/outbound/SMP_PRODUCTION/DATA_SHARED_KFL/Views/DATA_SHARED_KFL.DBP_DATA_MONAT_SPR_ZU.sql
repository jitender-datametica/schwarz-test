CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_monat_spr_zu (mo_id, spr_id, mo_bez, td_update, td_insert
) AS SELECT mo_id,
 spr_id,
 mo_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.monat_spr_zu;