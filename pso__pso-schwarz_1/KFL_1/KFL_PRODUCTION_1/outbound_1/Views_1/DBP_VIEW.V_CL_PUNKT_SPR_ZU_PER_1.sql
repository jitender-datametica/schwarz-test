CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cl_punkt_spr_zu_per_1 AS SELECT checkliste_punkt_id,
 spr_id,
 dat_von,
 dat_bis,
 cl_punkt_bez,
 cl_punkt_langtext,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cl_punkt_spr_zu_per_1;