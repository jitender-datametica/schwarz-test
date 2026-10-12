CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_mitarbeiter AS SELECT V00.mandant_id,
 V00.ma_id,
 COALESCE(V01.ma_ldap, '') AS ma_ldap,
 COALESCE(V01.email, '') AS ma_email,
 COALESCE(V01.mobil_tel, '') AS ma_mobil_tel,
 '' AS ma_funktion_sb,
 V02.ma_funktion_id AS ma_bereich_sb,
 V03.ma_funktion_id AS ma_position_sb,
 V10.beurteiler_id,
 V10.operativ_fg,
 V10.anz_sb_soll,
 V10.anz_sb_gelb_bis,
 V10.anz_sb_rot_bis
FROM kfl_production_dbp_view.v_l_ma AS V00
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu AS V01 ON V00.mandant_id = V01.mandant_id AND V00.ma_id = V01.ma_id
 INNER JOIN kfl_production_dbp_view.v_sb_beurteiler AS V10 ON V00.ma_id = V10.ma_id AND V00.mandant_id = V10.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_ma_hierarchie_ma_zu_per AS V02 ON V00.ma_id = V02.ma_id AND V02.ma_hierarchie_typ_id
     = 2 AND V02.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_ma_hierarchie_ma_zu_per AS V03 ON V00.ma_id = V03.ma_id AND V03.ma_hierarchie_typ_id
     = 3 AND V03.dat_bis = DATE '9999-12-31'
WHERE V00.dat_bis = DATE '9999-12-31';