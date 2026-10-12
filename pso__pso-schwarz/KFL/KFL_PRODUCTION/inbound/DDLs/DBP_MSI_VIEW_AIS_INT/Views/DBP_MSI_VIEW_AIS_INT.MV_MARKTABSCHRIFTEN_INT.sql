CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MARKTABSCHRIFTEN_INT
(
	MANDANT_ID,
	WUP_ID,
	WUP_ABSCHRIFT_ID,
	POSITIONSNUMMER,
	ABSCHRIFTENART_ID,
	NB_ID,
	DAT,
	ABSCHRIFTEN_MENGE,
	ART_ID,
	ABSCHRIFTENBETRAG_NETTO,
	ABSCHRIFTENBETRAG_BRUTTO,
	GP_ID,
	WV_KZ,
	WV_GRUND_ID,
	UMBEW_BELEG_ID,
	WRG_ID,
	WERBEABSCHRIFT_PV,
      WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL,
      WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE,
	WERBEABSCHRIFT_REST
)
AS

--Sebastian Gross, 12.08.2024
--Die View fasst alle bestehenden Views aus AIS DE und AIS KMO rund um Abschriften und Preisänderungen zusammmen. Es gibt im Vergleich dazu einige Änderungen. 
--In DE werden statt 2 Spalten für Ab- und Aufschriften neue "AKZ" eingeführt für Aufschriften, damit es mit KMO zusammenführbar ist.

--Teil 1: Deutsche Abschriften Markt, ohne Aufschriften
SELECT
 v01.mandant_id
,v01.wup_id
,v01.wup_abschrift_id
,v01.positionsnummer_id
,CAST(v01.abschriftart_id AS STRING)
,v01.nb_id
,v01.dat
,CASE WHEN v01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto > 0 
      THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
      WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto > 0 
      THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
      WHEN v01.abschriftbetrag_netto > 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4)) 
      END AS ABSCHRIFTEN_MENGE
,v01.art_id
,CASE WHEN v01.abschriftbetrag_netto  > 0 THEN v01.abschriftbetrag_netto  ELSE 0 END AS ABSCHRIFTENBETRAG_NETTO
,CASE WHEN v01.abschriftbetrag_brutto > 0 THEN v01.abschriftbetrag_brutto ELSE 0 END AS ABSCHRIFTENBETRAG_BRUTTO
,COALESCE(v02.gp_id,-1) AS gp_id
,wv_kz
,wv_grund_id
,CAST(0 AS NUMBER(18,0))
,wrg_id
-- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_PV
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_REST
  
FROM dbp_view.v_marktabschriften v01
LEFT JOIN
(SELECT
 art_id
,gp_id
,wup_id
,dat_von
,dat_bis
FROM dbp_view.v_art_gp_nm_zu_per
WHERE  mandant_id = 1
) v02

ON  v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id
AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis

INNER JOIN
(SELECT
 art_id
,gewart_id
FROM dbp_view.v_art
WHERE mandant_id = 1
) v03

ON v01.art_id = v03.art_id
WHERE v01.mandant_id = 1 AND abschriftbetrag_netto > 0 
-- 15.10.2024 sschuecke / Herausfiltern abschriftart_id = -1, da diese  im letzten UNION mit mv_artbew ebenfalls enthalten ist
AND v01.abschriftart_id <> - 1
-- Sebastian Gross, 12.08.2024 Filterung wichtig, damit die Aufschriften nicht mitkommen (die hätten dann zwar alle Wert 0, wären aber als Zeilen da)


--Teil 2: Deutsche Abschriften Lager, ohne Aufschriften
UNION ALL

SELECT
 MANDANT_ID
,WUP_ID
,LAGERBEW_BELEG_ID
,LAGERBEW_BELEG_POS_ID
/*,CAST(CASE WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0020') THEN 210
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0027') THEN 211
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0026') THEN 212
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0040') THEN 213
      WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND grund_id IN ('0012') THEN 240
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0051') THEN 241
      WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND grund_id IN ('0029') THEN 242
      ELSE NULL END AS STRING) AS LAGER_BEWART_ID*/
,CAST(CASE WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0020') THEN 'BA0'
           WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0027') THEN 'BAA'
           WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0026') THEN 'BAB'
           WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0040') THEN 'BAC'
           WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND grund_id IN ('0012') THEN 'BD0'
           WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0051') THEN 'BDA'
           WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND grund_id IN ('0029') THEN 'BDB'
      ELSE NULL END AS STRING) AS LAGER_BEWART_ID
,NB_ID
,DAT_BUCH
,CASE WHEN MENGE_LAGERBEW_BME < 0 THEN MENGE_LAGERBEW_BME * -1 END AS ABSCHRIFTEN_MENGE
,ART_ID
,CASE WHEN BETRAG_VK_NETTO_VZ < 0 THEN CAST(BETRAG_VK_NETTO_VZ AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1 AS ABSCHRIFTENBETRAG_NETTO
,CASE WHEN BETRAG_VERKAUF < 0 THEN CAST(BETRAG_VERKAUF AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1 AS ABSCHRIFTENBETRAG_BRUTTO
,GP_ID
,'' AS WV_KZ
,CAST(0 AS NUMBER(18,0)) AS WV_GRUND_ID
,CAST(0 AS NUMBER(18,0)) AS UMBEW_BELEG_ID
,WRG_ID
-- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_PV
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_REST

FROM dbp_view.v_lagerbew_det
WHERE lager_bewart_id IN 
('V11','V12','V13','V10','W11','W12','W13','W10','V25','V26','V27','V28','W25','W26','W27','W28',
 'V50','V51','V52','V53','W50','W51','W52','W53','V54','V55','V56','V57','W54','W55','W56','W57')
AND grund_id IN ('0020','0027','0026','0040','0012','0051','0029')
AND mandant_id = 1
AND BETRAG_VK_NETTO_VZ < 0 
-- Filterung wichtig, damit die Aufschriften nicht mitkommen (die hätten dann zwar alle Wert 0, wären aber als Zeilen da)


-- Teil 3: Deutsche AUFschriften Markt
UNION ALL

SELECT
 v01.mandant_id
,v01.wup_id
,v01.wup_abschrift_id
,v01.positionsnummer_id
,CAST(v01.abschriftart_id *-1  AS STRING)
-- Sebastian Gross, 12.08.2024: AKZ wird hier zu negativen Zahlen umgekehrt. Grund ist dass das AUFschriften sind. Damit es mit KMO passt, können wir das nicht wie im AIS DE über eine eigene Metrik darstellen sondern es müssen eigene AKZ sein.
,v01.nb_id
,v01.dat
,CASE WHEN v01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto < 0 
      THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
      WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto < 0 
      THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
      WHEN v01.abschriftbetrag_netto < 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4)) 
      END AS ABSCHRIFTEN_MENGE  -- das sind Aufschriften
,v01.art_id
,CASE WHEN v01.abschriftbetrag_netto  < 0 THEN v01.abschriftbetrag_netto  ELSE 0 END AS ABSCHRIFTENBETRAG_NETTO  -- das sind Aufschriften
,CASE WHEN v01.abschriftbetrag_brutto < 0 THEN v01.abschriftbetrag_brutto ELSE 0 END AS ABSCHRIFTENBETRAG_BRUTTO -- das sind Aufschriften
,COALESCE(v02.gp_id,-1) AS gp_id
,wv_kz
,wv_grund_id
,CAST(0 AS NUMBER(18,0))
,wrg_id
-- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_PV
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_REST

FROM dbp_view.v_marktabschriften v01
LEFT JOIN
(SELECT
 art_id
,gp_id
,wup_id
,dat_von
,dat_bis
FROM dbp_view.v_art_gp_nm_zu_per
WHERE  mandant_id = 1
) v02

ON  v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id
AND v01.dat BETWEEN v02.dat_von
AND v02.dat_bis

INNER JOIN
(SELECT
 art_id
,gewart_id
FROM dbp_view.v_art
WHERE mandant_id = 1
) v03

ON v01.art_id = v03.art_id

WHERE v01.mandant_id = 1
AND v01.abschriftart_id NOT IN (-1)
AND abschriftbetrag_netto < 0


--Teil 4 Deutsche AUFschriften Lager
UNION ALL

SELECT
MANDANT_ID
,WUP_ID
,LAGERBEW_BELEG_ID
,LAGERBEW_BELEG_POS_ID
/*,CAST(CASE WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0020') THEN -210
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0027') THEN -211
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0026') THEN -212
      WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0040') THEN -213
      WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND grund_id IN ('0012') THEN -240
      WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0051') THEN -241
      WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND grund_id IN ('0029') THEN -242
      ELSE NULL END AS STRING) AS LAGER_BEWART_ID*/
,CAST(CASE WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0020') THEN 'BA0'
           WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0027') THEN 'BAA'
           WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0026') THEN 'BAB'
           WHEN lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND grund_id IN ('0040') THEN 'BAC'
           WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND grund_id IN ('0012') THEN 'BD0'
           WHEN lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND grund_id IN ('0051') THEN 'BDA'
           WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND grund_id IN ('0029') THEN 'BDB'
      ELSE NULL END AS STRING) AS LAGER_BEWART_ID
,NB_ID
,DAT_BUCH
,CASE WHEN MENGE_LAGERBEW_BME > 0 THEN MENGE_LAGERBEW_BME * -1 END -- Aufschriften Menge
,ART_ID
,CASE WHEN BETRAG_VK_NETTO_VZ > 0 THEN CAST(BETRAG_VK_NETTO_VZ AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1 -- Aufschriften VK netto
,CASE WHEN BETRAG_VERKAUF > 0 THEN CAST(BETRAG_VERKAUF AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1 -- Aufschriften VK brutto
,GP_ID
,'' AS WV_KZ
,CAST(0 AS NUMBER(18,0)) AS WV_GRUND_ID
,CAST(0 AS NUMBER(18,0)) AS UMBEW_BELEG_ID
,WRG_ID
-- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_PV
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_REST

FROM dbp_view.v_lagerbew_det
WHERE lager_bewart_id IN 
('V11','V12','V13','V10','W11','W12','W13','W10','V25','V26','V27','V28','W25','W26','W27','W28',
 'V50','V51','V52','V53','W50','W51','W52','W53','V54','V55','V56','V57','W54','W55','W56','W57')
AND grund_id IN ('0020','0027','0026','0040','0012','0051','0029')
AND mandant_id = 1
AND BETRAG_VK_NETTO_VZ > 0 
-- Sebastian Gross, 12.08.2024: Filterung wichtig, damit die ABschriften nicht mitkommen (die hätten dann zwar alle Wert 0, wären aber als Zeilen da)

--KMO komplett

UNION ALL

SELECT
 v01.mandant_id
,v01.wup_id
,v01.wup_abschrift_id
,v01.positionsnummer_id
,v01.abschriftart_id
,v01.nb_id
,v01.dat
,CASE WHEN v01.gewart_id = 'KG' THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000 ELSE CAST(v01.menge_abschrift AS DECIMAL(13,4)) END  * -1 AS Abschriften_Menge
,v01.art_id
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.abschriftbetrag_netto  ,0) 
           WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.abschriftbetrag_netto  ,0) * v01.umrechnungskurs_0
           WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.abschriftbetrag_netto  ,0) * v01.umrechnungskurs_1
           END AS DECIMAL(18,6)) * -1 AS abschriftbetrag_netto
,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE( v01.abschriftbetrag_brutto  ,0) 
           WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.abschriftbetrag_brutto  ,0) * v01.umrechnungskurs_0
           WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.abschriftbetrag_brutto  ,0) * v01.umrechnungskurs_1
           END AS DECIMAL(18,6)) * -1 AS abschriftbetrag_brutto
,COALESCE(v01.gp_id, -1)
,'' AS WV_KZ
,CAST(0 AS NUMBER(18,0)) AS WV_GRUND_ID
,CAST(0 AS NUMBER(18,0)) AS UMBEW_BELEG_ID
,'' AS WRG_ID
-- Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_PV
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE
,CAST(0 AS NUMBER(38,5)) AS WERBEABSCHRIFT_REST


FROM 
(SELECT
    v01.mandant_id
   ,v01.wup_id
   ,v01.wup_abschrift_id
   ,v01.positionsnummer_id
   ,CAST(v01.abschriftart_id AS STRING) AS abschriftart_id
   ,v01.nb_id
   ,v01.dat
   ,v01.menge_abschrift
   ,v01.art_id
   ,v01.abschriftbetrag_netto
   ,v01.abschriftbetrag_brutto
   ,v02.gp_id
   ,v03.gewart_id
   ,v200.umrechnungskurs AS umrechnungskurs_0
   ,v300.umrechnungskurs AS umrechnungskurs_1
   
   FROM dbp_view.v_marktabschriften v01
   LEFT JOIN dbp_view.v_art_gp_nm_zu_per v02
   ON v01.art_id = v02.art_id
   AND v01.wup_id =v02.wup_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis

   JOIN dbp_view.v_art v03
   ON  v01.mandant_id = v03.mandant_id 
   AND v01.art_id     = v03.art_id

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id

   -- Umrechnung Standardkurs, Tageskurs
   /*-- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs v300
   ON  v01.dat BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs v200
   ON v200.dat_bis = '9999-12-31'
   AND v01.wrg_id = v200.von_wrg_id
   AND v200.kurstyp_id = 3
   AND v200.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs v300
   ON v01.dat BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'


   WHERE v01.abschriftart_id BETWEEN 905 AND 994
   AND v01.mandant_id <> 1
   AND NOT (v01.abschriftart_id = 955
   AND v01.mandant_id = 2)
   
   
   UNION ALL

 SELECT
  v01.MANDANT_ID
 ,v01.WUP_ID
 ,v01.LAGERBEW_BELEG_ID
 ,v01.LAGERBEW_BELEG_POS_ID
 ,CAST(CASE WHEN v01.lager_bewart_id IN ('Y01','Y02') THEN 210
       WHEN v01.lager_bewart_id IN ('Y07','Y08') THEN 211
       WHEN v01.lager_bewart_id IN ('Y11','Y12') THEN 240
       WHEN v01.lager_bewart_id IN ('Y05','Y06') THEN 241
       WHEN v01.lager_bewart_id IN ('Y35','Y36') THEN 242
       ELSE NULL END AS STRING) AS LAGER_BEWART_ID
 ,v01.NB_ID
 ,v01.DAT_BUCH
 ,CASE WHEN v03.GEWART_ID = 'KG' THEN v01.MENGE_LAGERBEW_BME * 1000 ELSE v01.MENGE_LAGERBEW_BME END AS Menge
 ,v01.ART_ID
 ,v01.BETRAG_VK_NETTO_VZ
 ,v01.BETRAG_VERKAUF
 ,v01.GP_ID
 ,v03.GEWART_ID
 ,v200.UMRECHNUNGSKURS AS umrechnungskurs_0
 ,v300.UMRECHNUNGSKURS AS umrechnungskurs_1

 FROM dbp_view.v_lagerbew_det v01

 JOIN dbp_view.v_art v03
 ON  v01.mandant_id = v03.mandant_id 
 AND v01.art_id = v03.art_id
 
  /*JOIN dbp_view.v_kurs v300
 ON  v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
 AND v01.wrg_id = v300.von_wrg_id
 AND v300.kurstyp_id = 9
 AND v300.nach_wrg_id ='EUR'*/

-- JOIN aktueller Berichtskurs
JOIN dbp_view.v_kurs v200
ON v200.dat_bis = '9999-12-31'
AND v01.wrg_id = v200.von_wrg_id
AND v200.kurstyp_id = 3
AND v200.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
JOIN dbp_view.v_kurs v300
ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
AND v01.wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id ='EUR'

 WHERE v01.lager_bewart_id IN ('Y01','Y02','Y07','Y08','Y11','Y12','Y05','Y06','Y35','Y36')
 AND v01.mandant_id <> 1
  ) v01

  CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
  
-- Werbeabschriften komplett AP0213409/SPEC0247905 sschuecke 16.09.2024
	UNION ALL

    SELECT
	 mandant_id
	,wup_id
	,CAST(0 AS NUMBER(18,0)) AS wup_abschrift_id
	,CAST(0 AS NUMBER(18,0)) AS positionsnummer
	,'' AS abschriftenart_id
	,nb_id
	,dat
	,CAST(0 AS NUMBER(38,5)) AS abschriften_menge
	,art_id
	,CAST(0 AS NUMBER(38,5)) AS abschriftenbetrag_netto
	,CAST(0 AS NUMBER(38,5)) AS abschriftenbetrag_brutto
	,gp_id
	,'' AS wv_kz
	,CAST(0 AS NUMBER(18,0)) AS wv_grund_id
	,CAST(0 AS NUMBER(18,0)) AS umbew_beleg_id
	,wrg AS wrg_id
    ,WERBEABSCHRIFT_PV
    ,WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL
    ,WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE
    ,WERBEABSCHRIFT_REST
	
	FROM DBP_MSI_VIEW_AIS_INT.MV_ARTBEW;
