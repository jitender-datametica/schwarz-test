CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WG_PER
(
wg_id
, arthiertyp_id
, lead_mwst_id
, dat_von
, abt_id
, mandant_id
, dat_bis
, owg_id
)
AS
   SELECT
   wg_id, arthiertyp_id, lead_mwst_id, dat_von, abt_id, mandant_id, dat_bis, owg_id

   FROM dbp_view.v_wg_per
   WHERE mandant_id = 1
   AND arthiertyp_id = 2
   AND dat_bis > CURRENT_DATE;