CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ma AS SELECT V01.mandant_id,
 V01.ma_id,
 V02.ma_ldap,
 V02.email,
 V02.mobil_tel
FROM kfl_production_dbp_view.v_l_ma AS V01
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.ma_id = V02.ma_id
WHERE V01.dat_bis = DATE '9999-12-31';