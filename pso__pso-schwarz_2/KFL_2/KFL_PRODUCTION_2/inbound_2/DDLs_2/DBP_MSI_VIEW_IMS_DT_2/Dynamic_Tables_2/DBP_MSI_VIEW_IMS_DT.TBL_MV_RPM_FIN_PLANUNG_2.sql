CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.TBL_MV_RPM_FIN_PLANUNG_2
(
	DAT_VON,
	RPM_HIERARCHIE_ID,
	FIN_KAT_HIERARCHIE_ID,
	FIN_KATEGORIE_ID,
	FIN_KAT_VERSION_ID,
	FIN_KAT_VERSION_DAT,
	FIN_GRUPPE_HIERARCHIE_ID,
	FIN_GRUPPE_ID,
	RPM_PLANTYP_ID,
	FIN_GRUPPE_VERSION_ID,
	FIN_GRUPPE_VERSION_DAT,
	DAT_START,
	MAXKP_FG,
	UMRECHNUNGSKURS,
	BETRAG
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 03.06.2013 twie: Viewlogik aus IOS übernommen, Bezeichnungen entfernt
-- 29.010.2013 AL Fin Plan Typen analog IOS ergänzt

   SELECT
   v01.dat_von,
   v03.rpm_hierarchie_id,
   v03.fin_kat_hierarchie_id,
   v03.fin_kategorie_id,
   COALESCE(v03.fin_kat_version_id, ' ') AS fin_kat_version_id,
   v03.fin_kat_version_dat,
   v02.fin_gruppe_hierarchie_id,
   v02.fin_gruppe_id,
   v01.rpm_plantyp_id,
   v02.fin_gruppe_version_id,
   v02.fin_gruppe_version_dat,
   v01.dat_start,
   COALESCE (V020.maxkp_fg,0) AS maxkp_fg,
   v300.umrechnungskurs,
   v01.betrag

  FROM dbp_view.v_rpm_fin_kategorie_2 v03

   LEFT OUTER JOIN dbp_view.v_rpm_fin_gruppe_2 v02
   ON v03.fin_kategorie_id = v02.fin_kategorie_id
   AND v03.fin_kat_hierarchie_id = v02.fin_kat_hierarchie_id

   LEFT OUTER JOIN dbp_view.v_rpm_fin_plan_2 v01
   ON v02.fin_gruppe_hierarchie_id = v01.fin_gruppe_hierarchie_id
   AND  v01.dat_bis =  '9999-12-31'

   LEFT OUTER JOIN (SELECT fk.rpm_hierarchie_id,
   MAX(fp.rpm_plantyp_id) AS rpm_plantyp_id,
   1 AS maxkp_fg
   FROM dbp_view.v_rpm_fin_plan_2 fp
   JOIN dbp_view.v_rpm_fin_gruppe_2 fg
   ON fp.fin_Gruppe_hierarchie_id=fg.fin_gruppe_hierarchie_id
   JOIN dbp_view.v_rpm_fin_kategorie_2 fk
   ON fg.fin_kat_hierarchie_id=fk.fin_kat_hierarchie_id
   WHERE
   fp.dat_bis='9999-12-31' AND
   fp.rpm_plantyp_id IN (1,2,3,4,11,21,22,23,24,25,26) --29.10.2013 Änderung lt. Hr. Kehnen;neue Plantypen hinzugefügt
   GROUP BY 1
   HAVING SUM(betrag)<>0
   ) V020
   ON
   v03.rpm_hierarchie_id=V020.rpm_hierarchie_id AND
   v01.rpm_plantyp_id=V020.rpm_plantyp_id

   -- Umrechnung Standardkurs, Berichtkurs
   JOIN dbp_view.v_kurs_2 v300
   ON v01.dat_von BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'
;