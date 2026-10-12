CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_HR_MASSNAHME_SPR_ZU_PL_1
(
mandant_id
, hr_massnahme_grund_id
, hr_massnahme_id
, hr_massnahme_grund_bez
)
AS
   SELECT
   v01.mandant_id, v01.hr_massnahme_grund_id, v01.hr_massnahme_id, v01.hr_massnahme_grund_bez

   FROM dbp_view.v_hr_massnahme_spr_zu_1 v01
   WHERE v01.spr_id = 90
;