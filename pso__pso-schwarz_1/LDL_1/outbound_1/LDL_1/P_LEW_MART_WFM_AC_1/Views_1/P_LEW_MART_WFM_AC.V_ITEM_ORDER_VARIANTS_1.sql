CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_item_order_variants_1 (client_id, mandant_1, betriebsgesellschaft,
sammelartikel, artikelvariante, artikelart, belieferart, bestellbereich, valid_var, artikelstatus, basis_me, anliefer_me
, zaehler, nenner, unter_me, log_variante) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_item_order_variants_1;