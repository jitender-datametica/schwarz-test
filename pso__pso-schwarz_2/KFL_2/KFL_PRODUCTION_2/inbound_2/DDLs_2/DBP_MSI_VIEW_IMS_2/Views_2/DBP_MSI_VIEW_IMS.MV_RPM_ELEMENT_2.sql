CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_RPM_ELEMENT_2 AS
-- 03.06.2013 twie: Viewlogik aus IOS übernommen, ggf. noch  verschlanken
-- 04.06.2013 twie: Ermittlung von eigentum_bez auskommentiert, da hierduch Datenvervielfältigungen
-- 12.06.2013 twie: Verbindung zu in_projekt_2
-- 24.06.2013 twie: Neuaufbau View; alle Projekte, wenn vorhanden rpm dazu, sonst -1
-- 08.07.2014 twie: projekt_ext_id aus inpr holen statt v01

   SELECT
   COALESCE(v01.rpm_hierarchie_id,'-1') AS rpm_hierarchie_id,
   v01.dat_von,
   inpr.projekt_ext_id,
   inpr.in_projekt_id,
   inpr.mandant_id,
   v01.dat_bis,
   v01.rpm_status_id,
   v01.dat_start_prognose,
   v01.dat_start_plan,
   v01.dat_start,
   v01.dat_ende_prognose,
   v01.dat_ende_plan,
   v01.dat_ende,
   v01.land_id,
   COALESCE(v01.rpm_phase_id, '1') AS rpm_phase_id,
   COALESCE(v01.rpm_projekt_typ_id, 'ZPPM_SONSTIGES') AS rpm_projekt_typ_id

   FROM dbp_view.v_in_projekt_2 inpr
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_rpm_element_per_2 t
   WHERE t.dat_bis = '9999-12-31'
   AND t.rpm_status_id <> -1
   ) v01
   ON v01.projekt_id = inpr.projekt_ext_id
   ;