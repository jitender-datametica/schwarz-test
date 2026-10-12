CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_HR_MASSNAHME_2
(
mandant_id
, hr_massnahme_grund_id
, hr_massnahme_id
)
AS
   SELECT
   v01.mandant_id, v01.hr_massnahme_grund_id, v01.hr_massnahme_id

   FROM dbp_view.v_l_hr_massnahme_2 v01;