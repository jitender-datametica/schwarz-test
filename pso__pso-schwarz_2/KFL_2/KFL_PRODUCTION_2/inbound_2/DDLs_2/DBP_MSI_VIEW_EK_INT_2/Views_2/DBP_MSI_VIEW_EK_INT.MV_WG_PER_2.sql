CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WG_PER_2
(
mandant_id
, arthiertyp_id
, lead_mwst_id
, wg_id
, abt_id
, dat_von
, dat_bis
, owg_id
)
AS
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.lead_mwst_id, v01.wg_id, v01.abt_id, v01.dat_von, v01.dat_bis, v01.owg_id

   FROM dbp_view.v_wg_per_2 v01

   WHERE dat_bis > CURRENT_DATE
   AND   arthiertyp_id = 2;