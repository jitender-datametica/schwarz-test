CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_SHR_NCS_EMPFAENGER
(
mandant_id
, hr_objekt_ebene1_id
, email
, vorname
, nachname
, geschlecht_id
, kjmo
)
AS
   SELECT
   v01.mandant_id, v01.hr_objekt_ebene1_id, v01.email, v01.vorname, v01.nachname, v01.geschlecht_id, v01.kjmo
   FROM dbp_security.shr_ncs_empfaenger v01
   JOIN dbp_msi_view_shr.mv_abrechnungsmonat v02
   ON v01.kjmo = v02.kjmo_abr
   AND v01.mandant_id = v02.mandant_id;