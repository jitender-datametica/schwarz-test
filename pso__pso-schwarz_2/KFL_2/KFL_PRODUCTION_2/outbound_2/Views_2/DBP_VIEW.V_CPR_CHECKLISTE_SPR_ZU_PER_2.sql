CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_checkliste_spr_zu_per_2 AS SELECT cpr_checkliste_id,
 dat_von,
 spr_id,
 dat_bis,
 cpr_checkliste_bez,
 cpr_checkliste_langtext,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_checkliste_spr_zu_per_2;