CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_spr_zu (ma_id, spr_id, ma_anrede, ma_name, ma_vorname, email,
mobil_tel, ma_ldap, mandant_id, td_update, td_insert) AS SELECT ma_id,
 spr_id,
 ma_anrede,
 ma_name,
 ma_vorname,
 email,
 mobil_tel,
 ma_ldap,
 mandant_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ma_spr_zu;