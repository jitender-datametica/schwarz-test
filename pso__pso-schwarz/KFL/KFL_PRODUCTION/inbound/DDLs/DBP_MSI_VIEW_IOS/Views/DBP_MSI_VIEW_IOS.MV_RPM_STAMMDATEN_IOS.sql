CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_STAMMDATEN_IOS
(
--20170623 hmue2308: Redesign IOS
--AP0004982


projekt_id,
--wup_id,
ims_projekt_typ_id,
in_projekt_id_char,
--psp_id,
--mandant_id,
--psp_id_char,
besitzverhaeltnis_id,
rpm_projekt_typ_id,
rpm_phase_id,
rpm_hierarchie_id,
rpm_status_id
)
AS

   SELECT
   v01.projekt_id,
   --wup_id,
   v04.ims_projekt_typ_id,
   v04.in_projekt_id_char,
   --v03.psp_id,
   --v03.mandant_id,
   --v03.psp_id_char,
   v02.besitzverhaeltnis_id,
   v02.rpm_projekt_typ_id,
   v02.rpm_phase_id,
   v02.rpm_hierarchie_id,
   v02.rpm_status_id



   FROM dbp_view.v_cpr_projekt_bauabschnitt_zu v01 --SELECT-Ende

   INNER JOIN dbp_view.v_rpm_element_per v02
   ON v01.projekt_id = v02.projekt_id
   INNER JOIN dbp_view.v_in_projekt v04
   ON v02.rpm_projekt_typ_id = v04.rpm_projekt_typ_id;