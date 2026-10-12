CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_ORG_EINHEIT_ZU_PER
(
mandant_id
, hr_objekt_id
, mitarbeiter_id
, kjmo
)
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_id, v01.mitarbeiter_id, v01.kjmo

   --FROM dbp_view.v_ma_org_einheit_zu_per v01
   FROM
   dbp_view.v_mitarbeiterbew v01

   JOIN dbp_view.v_monat v02
   ON v02.kjmo = v01.kjmo;