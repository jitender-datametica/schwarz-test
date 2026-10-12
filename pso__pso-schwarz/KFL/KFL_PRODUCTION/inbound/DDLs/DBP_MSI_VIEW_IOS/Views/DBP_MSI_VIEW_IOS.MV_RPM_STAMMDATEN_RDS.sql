CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_STAMMDATEN_RDS AS
--20250122 alavih: Filialumgliederung
   SELECT
   v01.projekt_id,
   v03.ims_projekt_typ_id,
   v03.in_projekt_id_char,
   v01.mandant_id,
   COALESCE(v05.besitzstatus_id,' -1') AS besitzverhaeltnis_id,
   v02.rpm_projekt_typ_id,
   v02.rpm_phase_id,
   v02.rpm_hierarchie_id,
   v02.rpm_status_id,
   v02.objekt_planer_name,
   v02.wup_standort,
  -- v02.wup_id,
   COALESCE(w.aktuell_wup_id,v02.wup_id) AS wup_id, --nur aktuell gültige WUP,
   TRIM(pr.techn_platz_id)  AS techn_platz_id


   FROM dbp_view.v_cpr_projekt_per v01
   INNER JOIN dbp_view.v_rpm_element_per  v02
   ON   v02.projekt_id  = v01.cpr_ext_id
   AND v02.dat_bis = v01.dat_bis
   
   LEFT JOIN dbp_view.v_wup w 
   ON v02.wup_id = w.wup_id 
   AND v02.mandant_id = w.mandant_id -- Filterung auf aktuell gültige WUP
   
   LEFT JOIN dbp_view.v_in_projekt v03
   ON   v01.cpr_ext_id = v03.projekt_ext_id
   AND v01.mandant_id = v03.mandant_id
   LEFT JOIN (
   SELECT DISTINCT
   we.mandant_id, wirtschaftseinheit_id, we.besitzstatus_id
   FROM dbp_view.v_immo_wirtschaftseinheit we
   WHERE Current_Date BETWEEN dat_we_gueltig_von AND dat_we_gueltig_bis
   AND (we.mandant_id,we_intreno) NOT IN (
   SELECT mandant_id, we_intreno
   FROM dbp_view.v_immo_wirtschaftseinheit
   WHERE CONTAINS( wirtschaftseinheit_bez, 'paob')
   OR CONTAINS( wirtschaftseinheit_bez, 'UMGL')
   )) v05
   ON v01.mandant_id = v05.mandant_id
   AND v02.wup_id = v05.wirtschaftseinheit_id

   -- Einfügen techn. Platz ID
   JOIN
   dbp_view.v_cpr_projekt_per pr
   ON   v01.projekt_id  = pr.projekt_id
   AND v01.dat_bis = pr.dat_bis
   



   WHERE v01.dat_bis = '9999-12-31';