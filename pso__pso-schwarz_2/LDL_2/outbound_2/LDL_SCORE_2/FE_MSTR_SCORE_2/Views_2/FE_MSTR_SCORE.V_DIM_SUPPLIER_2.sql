CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_supplier_2 AS SELECT supplier_sid,
 supplier_nr,
 supplier_abbr_name,
 supplier_short_name,
 supplier_name,
 int_negot_fg,
 vat_nr
FROM ldl_score_core.t_dim_supplier_2;