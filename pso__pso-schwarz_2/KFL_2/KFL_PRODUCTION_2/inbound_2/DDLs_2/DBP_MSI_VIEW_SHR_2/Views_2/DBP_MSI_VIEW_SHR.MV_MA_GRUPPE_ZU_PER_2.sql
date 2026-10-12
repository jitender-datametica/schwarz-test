CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_GRUPPE_ZU_PER_2
(
mandant_id
, mitarbeiter_gruppe_id
, mitarbeiter_id
, kjmo
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id, v01.mitarbeiter_id, v01.kjmo
   FROM dbp_view.v_ma_gruppe_zu_per_2 v01;