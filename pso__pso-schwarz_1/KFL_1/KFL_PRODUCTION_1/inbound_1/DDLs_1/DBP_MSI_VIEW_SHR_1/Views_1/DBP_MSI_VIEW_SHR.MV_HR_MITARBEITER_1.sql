CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_HR_MITARBEITER_1
(
mandant_id
, mitarbeiter_id
, dat_geburtstag
, land_id
, dat_uebernahme_azubi
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_id, v01.dat_geburtstag, v01.land_id, v01.dat_uebernahme_azubi

   FROM dbp_view.v_hr_mitarbeiter_1 v01;