CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_MARKTABSCHRIFTEN_1
(
     MANDANT_ID,
	WUP_ID,
	WUP_ABSCHRIFT_ID,
	POSITIONSNUMMER_ID,
	ABSCHRIFTART_ID,
	NB_ID,
	DAT,
	WOCHE_ID,
	ART_ID,
	LASTUPD_DAT,
	GEWART_ID,
	GP_ID,
     POSTEN_KZ_PER,
	MENGE_ABSCHRIFT,
	ABSCHRIFTBETRAG_BRUTTO,
	UMRECHNUNGSKURS_0,
     UMRECHNUNGSKURS_1,
	ABSCHRIFTBETRAG_NETTO
     ) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
--  AL 22.03.2012 Anpassung INNER JOIN auf LEFT JOIN bei art_gp_nm_zu_per_1
-- AL  26.03.2012 Teilen Menge durch 1000 bei Gewichtsartikel (in der Beladung wird mit 1000 multipliziert)
-- Awol 21.06.12: Join auf bei art_gp_nm_zu_per_1 angepasst. AND v01.mandant_id = v02.mandant_id
-- Awol 13.03.13: Where Bedingung von "v01.abschriftart_id BETWEEN 933 AND 994" auf "v01.abschriftart_id BETWEEN 905 AND 994" geändert. S. Mail Frau Winter 11.03.13
-- AP0034888, SPEC0119166 Lagerbewegungen added
AS
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.wup_abschrift_id,
   v01.positionsnummer_id,
   v01.abschriftart_id,
   v01.nb_id,
   v01.dat,
   v01.woche_id,
   v01.art_id,
   v01.lastupd_dat,
   v03.gewart_id,
   v02.gp_id,
   -- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
   CASE WHEN v200.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER,
   v01.menge_abschrift,
   v01.abschriftbetrag_brutto,
   v300.umrechnungskurs AS umrechnungskurs_0,
   v400.umrechnungskurs AS umrechnungskurs_1,
   v01.abschriftbetrag_netto
  FROM DBP_DATA.MARKTABSCHRIFTEN_1 v01
   LEFT JOIN DBP_DATA.ART_GP_NM_ZU_PER_1 v02
   ON  v01.art_id = v02.art_id
   AND v01.wup_id =v02.wup_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis

   JOIN DBP_DATA.ART_1 v03
   ON  v01.mandant_id = v03.mandant_id
   AND v01.art_id = v03.art_id

   JOIN DBP_DATA.MANDANT_1 v100
   ON v01.mandant_id = v100.mandant_id

  -- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
   LEFT JOIN DBP_DATA.ART_PER_1 v200
   ON v01.mandant_id = v200.mandant_id
   AND v01.art_id = v200.art_id
   AND v01.dat BETWEEN v200.dat_von AND v200.dat_bis

   /*-- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v01.dat BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN DBP_DATA.KURS_1 v300
   ON  v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN DBP_DATA.KURS_1 v400
   ON  v01.dat BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.abschriftart_id BETWEEN 905 AND 994
   AND v01.mandant_id <> 1
   AND
   NOT (v01.abschriftart_id = 955
   AND v01.mandant_id = 2)
   
   UNION ALL

 SELECT
 v01.MANDANT_ID
 ,v01.WUP_ID
 ,v01.LAGERBEW_BELEG_ID
 ,v01.LAGERBEW_BELEG_POS_ID
 ,CASE 
 WHEN v01.lager_bewart_id IN ('Y01','Y02') THEN 210
 WHEN v01.lager_bewart_id IN ('Y07','Y08') THEN 211
 WHEN v01.lager_bewart_id IN ('Y11','Y12') THEN 240
 WHEN v01.lager_bewart_id IN ('Y05','Y06') THEN 241
 WHEN v01.lager_bewart_id IN ('Y35','Y36') THEN 242
 END LAGER_BEWART_ID
 ,v01.NB_ID
 ,v01.DAT_BUCH
 ,CAST(CASE WHEN WEEK(v01.DAT_BUCH) < 10 
      THEN CONCAT(YEAR(v01.DAT_BUCH),'0',WEEK(v01.DAT_BUCH)) 
      ELSE CONCAT(YEAR(v01.DAT_BUCH),WEEK(v01.DAT_BUCH))END AS NUMBER(38,0))
 ,v01.ART_ID
 ,v01.DAT_BUCH
 ,v03.GEWART_ID
 ,v01.GP_ID
 -- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
 ,CASE WHEN v200.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
 ,CASE WHEN v03.GEWART_ID = 'KG' THEN v01.MENGE_LAGERBEW_BME * 1000 ELSE v01.MENGE_LAGERBEW_BME END
 ,v01.BETRAG_VERKAUF
 ,v300.UMRECHNUNGSKURS AS umrechnungskurs_0
 ,v400.umrechnungskurs AS umrechnungskurs_1
 ,v01.BETRAG_VK_NETTO_VZ
 FROM DBP_DATA.LAGERBEW_DET_1 v01

 JOIN DBP_DATA.ART_1 v03
 ON v01.mandant_id = v03.mandant_id 
 AND v01.art_id = v03.art_id

-- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
LEFT JOIN DBP_DATA.ART_PER_1 v200
ON  v01.mandant_id = v200.mandant_id
AND v01.art_id = v200.art_id
AND v01.dat_buch BETWEEN v200.dat_von AND v200.dat_bis

 /*JOIN
 dbp_view.v_kurs_1 v300
 ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
 AND v01.wrg_id = v300.von_wrg_id
 AND v300.kurstyp_id = 9
 AND v300.nach_wrg_id ='EUR'*/

-- JOIN aktueller Berichtskurs
JOIN DBP_DATA.KURS_1 v300
ON  v300.dat_bis = '9999-12-31'
AND v01.wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
JOIN DBP_DATA.KURS_1 v400
ON  v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
AND v01.wrg_id = v400.von_wrg_id
AND v400.kurstyp_id = 3
AND v400.nach_wrg_id ='EUR'
 
WHERE v01.lager_bewart_id IN ('Y01','Y02','Y07','Y08','Y11','Y12','Y05','Y06','Y35','Y36')
AND v01.mandant_id <> 1;