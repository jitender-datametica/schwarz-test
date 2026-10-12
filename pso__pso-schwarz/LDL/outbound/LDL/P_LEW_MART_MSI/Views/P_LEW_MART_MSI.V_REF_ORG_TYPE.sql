CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_org_type (org_type_id, org_type_desc, dat_dayend, load_id) AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_ref_org_type AS T;