CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_GP_UMS_EK_1
(
gp_id
,kj_bezugsjahr
,teilgebiet
,Lief_Umsatz
,umsatz_wrg_id
)
AS
   SELECT
  distinct gp_id, kj_bezugsjahr, teilgebiet, umsatz_netto, umsatz_wrg_id

   FROM dbp_view.v_gp_ums_ek_1
   WHERE mandant_id = 1;