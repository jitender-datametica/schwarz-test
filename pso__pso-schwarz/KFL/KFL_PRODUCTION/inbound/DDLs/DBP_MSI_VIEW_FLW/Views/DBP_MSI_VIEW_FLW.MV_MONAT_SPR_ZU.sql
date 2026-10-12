CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MONAT_SPR_ZU
(mo_gj
,mo_bez
)
AS
   SELECT
   CASE WHEN mo_id >= 3 THEN mo_id -2 ELSE mo_id + 10 END AS mo_gj, mo_bez

   FROM dbp_view.v_monat_spr_zu  v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;