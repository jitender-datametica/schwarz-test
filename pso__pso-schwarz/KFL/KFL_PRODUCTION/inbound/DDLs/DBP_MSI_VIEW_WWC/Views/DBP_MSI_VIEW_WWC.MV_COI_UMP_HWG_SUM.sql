CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_HWG_SUM
(
mandant_id,
wup_id,
nb_id,
dat,
hwg_id,
wrg_id,
umsatz_netto
)
AS
   SELECT
   mandant_id,
   wup_id,
   nb_id,
   dat,
   hwg_id,
   wrg_id,
   umsatz_netto
   FROM dbp_view.v_coi_ump_hwg_sum;