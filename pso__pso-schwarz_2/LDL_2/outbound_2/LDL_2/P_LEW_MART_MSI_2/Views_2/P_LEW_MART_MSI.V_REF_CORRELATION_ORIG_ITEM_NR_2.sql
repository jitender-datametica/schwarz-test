CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_correlation_orig_item_nr_2 AS SELECT orig_item_nr,
 orig_item_desc,
 mis_login,
 buyer_fg,
 buyer_short_desc
FROM ldl_p_lew_core_ac.v_wawi_ref_correlation_orig_item_nr_2 AS RCV;