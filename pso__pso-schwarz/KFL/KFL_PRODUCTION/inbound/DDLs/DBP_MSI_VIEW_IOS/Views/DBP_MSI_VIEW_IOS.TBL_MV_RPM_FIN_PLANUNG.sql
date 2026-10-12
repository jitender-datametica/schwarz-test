CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.TBL_MV_RPM_FIN_PLANUNG
-- kkaiser: 20150921 Projekt 533, Einschränkung auf rpm_plantyp_id rausgenommen
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
,umrechnungskurs
)
AS
   SELECT
   v01.dat_von, v03.rpm_hierarchie_id, v03.fin_kat_hierarchie_id, v03.fin_kategorie_id, COALESCE(v03.fin_kat_version_id, '') as fin_kat_version_id, v03.fin_kat_version_dat, v02.fin_gruppe_hierarchie_id, v02.fin_gruppe_id, v01.rpm_plantyp_id, v02.fin_gruppe_version_id, v02.fin_gruppe_version_dat, v01.dat_start, coalesce (V020.maxkp_fg,0) as maxkp_fg,
   --CAST(
   --CASE
   --WHEN v200.wrg_typ_id  = 1
   --THEN COALESCE( v01.betrag   ,0)
   --WHEN  v200.wrg_typ_id  = 0
   --THEN COALESCE(v01.betrag   ,0) * v300.umrechnungskurs
   --END
   --AS DECIMAL(18,4) ) AS betrag,
  v01.betrag,
  v05.projekt_id AS projekt_nr, v06.projekt_id, v300.umrechnungskurs

   FROM dbp_view.v_rpm_fin_kategorie v03
   LEFT OUTER JOIN dbp_view.v_rpm_fin_gruppe v02
   ON v03.fin_kategorie_id = v02.fin_kategorie_id
   AND v03.fin_kat_hierarchie_id = v02.fin_kat_hierarchie_id
   LEFT OUTER JOIN dbp_view.v_rpm_fin_plan v01
   ON v02.fin_gruppe_hierarchie_id = v01.fin_gruppe_hierarchie_id
   AND  v01.dat_bis = '9999-12-31'
   LEFT OUTER join (SELECT fk.rpm_hierarchie_id, max(fp.rpm_plantyp_id) as rpm_plantyp_id, 1 as maxkp_fg
   from dbp_view.v_rpm_fin_plan fp
   join dbp_view.v_rpm_fin_gruppe fg
   ON fp.fin_Gruppe_hierarchie_id=fg.fin_gruppe_hierarchie_id
   join dbp_view.v_rpm_fin_kategorie fk
   ON fg.fin_kat_hierarchie_id=fk.fin_kat_hierarchie_id
   where
   fp.dat_bis='9999-12-31'
   group by 1
   having sum(betrag)<>0
   ) V020
   ON
   v03.rpm_hierarchie_id=V020.rpm_hierarchie_id and
   v01.rpm_plantyp_id=V020.rpm_plantyp_id
   LEFT JOIN dbp_view.v_rpm_element_per v05
   ON v05.rpm_hierarchie_id = v03.rpm_hierarchie_id
   AND v05.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_cpr_projekt_per v06
   ON  v05.projekt_id = v06.cpr_ext_id
   AND v06.dat_bis = '9999-12-31'
  -- CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

   -- Umrechnung Standardkurs, Berichtkurs
   JOIN
   dbp_view.v_kurs v300
   ON v01.dat_von BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR';