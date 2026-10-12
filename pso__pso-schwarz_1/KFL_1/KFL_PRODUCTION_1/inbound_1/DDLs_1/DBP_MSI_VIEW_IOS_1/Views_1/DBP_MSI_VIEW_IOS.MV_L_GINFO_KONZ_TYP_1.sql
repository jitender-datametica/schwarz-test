CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_KONZ_TYP_1
(
ginfo_konz_typ_kz
,ginfo_konz_typ_bez

)
AS
   SELECT
   ginfo_konz_typ_kz, ginfo_konz_typ_bez

   FROM dbp_view.v_l_ginfo_konz_typ_1;