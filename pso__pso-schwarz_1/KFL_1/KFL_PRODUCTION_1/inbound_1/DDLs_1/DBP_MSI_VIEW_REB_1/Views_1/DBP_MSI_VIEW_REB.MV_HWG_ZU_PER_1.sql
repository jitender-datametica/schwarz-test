CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_HWG_ZU_PER_1
(
hwg_id
, mandant_id
, dat_von
, dat_bis
, arthiertyp_id
)
AS
   SELECT
   hwg_id, mandant_id, dat_von, dat_bis, arthiertyp_id

   FROM dbp_view.v_hwg_per_1
   WHERE mandant_id = 1
   AND CURRENT_DATE BETWEEN dat_von AND dat_bis;