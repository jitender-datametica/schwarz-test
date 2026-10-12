CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_price_type_2 (mdm_price_type_cd, mdm_price_type_name, mdm_price_type_descr
, lob_fg, market_fg, incoterm_fg, int_org_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT mdm_price_type_cd,
 mdm_price_type_name,
 mdm_price_type_descr,
 lob_fg,
 market_fg,
 incoterm_fg,
 int_org_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_price_type_2;