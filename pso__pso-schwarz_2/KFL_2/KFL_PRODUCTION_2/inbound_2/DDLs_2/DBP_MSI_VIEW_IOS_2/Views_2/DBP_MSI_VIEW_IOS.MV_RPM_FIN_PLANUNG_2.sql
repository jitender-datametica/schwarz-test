CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_FIN_PLANUNG_2
(
dat_von
, rpm_hierarchie_id
, fin_kat_hierarchie_id
, fin_kategorie_id
, fin_kat_version_id
, fin_kat_version_dat
, fin_gruppe_hierarchie_id
, fin_gruppe_id
, rpm_plantyp_id
, fin_gruppe_version_id
, fin_gruppe_version_dat
, dat_start
, maxkp_fg
, betrag
,projekt_nr
,projekt_id
)
AS
 SELECT 
  v01.dat_von
, v01.rpm_hierarchie_id
, v01.fin_kat_hierarchie_id
, v01.fin_kategorie_id
, v01.fin_kat_version_id
, v01.fin_kat_version_dat
, v01.fin_gruppe_hierarchie_id
, v01.fin_gruppe_id
, v01.rpm_plantyp_id
, v01.fin_gruppe_version_id
, v01.fin_gruppe_version_dat
, v01.dat_start
, v01.maxkp_fg
,   CAST(
   CASE
   WHEN v200.wrg_typ_id  = 1
   THEN COALESCE( v01.betrag   ,0)
   WHEN  v200.wrg_typ_id  = 0
   THEN COALESCE(v01.betrag   ,0) * v01.umrechnungskurs
   END
   AS DECIMAL(18,4) ) AS betrag
, v01.projekt_nr
, v01.projekt_id

FROM DBP_MSI_VIEW_IOS.TBL_MV_RPM_FIN_PLANUNG_2 v01
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
;