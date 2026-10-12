CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_HR_MASSNAHME_ZU_PER_1
(
mandant_id
, hr_massnahme_grund_id
, hr_massnahme_id
, mitarbeiter_id
, kjmo
)
AS
   SELECT
   v01.mandant_id, v01.hr_massnahme_grund_id, v01.hr_massnahme_id, v01.mitarbeiter_id, v01.kjmo
   FROM dbp_view.v_ma_hr_massnahme_zu_per_1 v01;