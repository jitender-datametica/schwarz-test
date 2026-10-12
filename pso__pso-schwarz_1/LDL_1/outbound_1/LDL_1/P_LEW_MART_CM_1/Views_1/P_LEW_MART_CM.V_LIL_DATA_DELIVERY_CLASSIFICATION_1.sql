CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_data_delivery_classification_1 (client_id, period_id, year_id,
period_type_id, dsc_nr, lfl_id, pp_lfl_id, py_lfl_id) AS SELECT C.client_id,
 DD.src_period_nr AS period_id,
 DD.period_year AS year_id,
 DD.period_type_id,
 DD.dsc_nr,
 DD.lfl_id,
 PPDD.lfl_id AS pp_lfl_id,
 PYDD.lfl_id AS py_lfl_id
FROM ldl_p_lew_core_ac.v_lil_data_delivery_classification_1 AS DD
 INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_client_1 AS C ON DD.src_region_cd = C.country_iso_cd
 INNER JOIN ldl_p_lew_mart_cm.v_lil_period_1 AS P ON DD.src_period_nr = P.per_id
 LEFT JOIN ldl_p_lew_core_ac.v_lil_data_delivery_classification_1 AS PPDD ON P.pp_per_id = PPDD.src_period_nr AND DD.src_region_cd
    = PPDD.src_region_cd
 LEFT JOIN ldl_p_lew_core_ac.v_lil_data_delivery_classification_1 AS PYDD ON P.py_per_id = PYDD.src_period_nr AND DD.src_region_cd
    = PYDD.src_region_cd;