CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_DATUMSART_ZU_PER_2
(
mandant_id
, datumsart_id
, mitarbeiter_id
, kjmo
, dat_von
)
AS
   SELECT
   v01.mandant_id, v01.datumsart_id, v01.mitarbeiter_id, v01.kjmo, v01.dat_von

   FROM dbp_view.v_ma_datumsart_zu_per_2 v01;