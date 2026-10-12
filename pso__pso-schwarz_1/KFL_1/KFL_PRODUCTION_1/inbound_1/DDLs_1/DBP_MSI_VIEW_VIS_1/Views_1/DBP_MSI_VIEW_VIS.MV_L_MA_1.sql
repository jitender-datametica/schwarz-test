CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_MA_1 as -- LOOKUP Mitarbeiter
   -- Enthält alle Mitarbeiter aus Hierarchie
   -- 201201 Initial
SELECT v01.mandant_id,
   v01.ma_id,
   v02.ma_ldap,
   v02.email,
   v02.mobil_tel
FROM dbp_view.v_l_ma_1 v01
JOIN dbp_view.v_ma_spr_zu_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.ma_id = v02.ma_id
WHERE dat_bis = '9999-12-31';