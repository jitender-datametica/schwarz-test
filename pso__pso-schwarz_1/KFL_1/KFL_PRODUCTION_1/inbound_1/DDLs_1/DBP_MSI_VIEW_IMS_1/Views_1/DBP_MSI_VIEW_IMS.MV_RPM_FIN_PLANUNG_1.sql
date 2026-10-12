CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_RPM_FIN_PLANUNG_1 AS
-- 03.06.2013 twie: Viewlogik aus IOS übernommen, Bezeichnungen entfernt
-- 29.010.2013 AL Fin Plan Typen analog IOS ergänzt

   SELECT
   v01.dat_von,
   v01.rpm_hierarchie_id,
   v01.fin_kat_hierarchie_id,
   v01.fin_kategorie_id,
   fin_kat_version_id,
   v01.fin_kat_version_dat,
   v01.fin_gruppe_hierarchie_id,
   v01.fin_gruppe_id,
   v01.rpm_plantyp_id,
   v01.fin_gruppe_version_id,
   v01.fin_gruppe_version_dat,
   v01.dat_start,
   maxkp_fg,
   CAST(
    CASE
    WHEN v200.wrg_typ_id  = 1
    THEN COALESCE( v01.betrag   ,0)
    WHEN  v200.wrg_typ_id  = 0
    THEN COALESCE(v01.betrag   ,0) * umrechnungskurs
    END
    AS DECIMAL(18,4) ) AS betrag

  FROM DBP_MSI_VIEW_IMS.TBL_MV_RPM_FIN_PLANUNG_1 v01
   
  -- Ermittlung der eingestellter Währung
  CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
;