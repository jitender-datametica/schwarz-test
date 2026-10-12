CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MARKTABSCHRIFTEN(
	MANDANT_ID,
	WUP_ID,
	WUP_ABSCHRIFT_ID,
	POSITIONSNUMMER,
	ABSCHRIFTENART_ID,
	NB_ID,
	DAT,
	WOCHE_ID,
	M_ABSCH_MENGE,
	M_AUFSCH_MENGE,
	ART_ID,
	POSTEN_KZ_PER,
	LASTUPD_DAT,
	ABSCHRIFTENBETRAG_NETTO,
	AUFSCHRIFTENBETRAG_NETTO,
	ABSCHRIFTENBETRAG_BRUTTO,
	AUFSCHRIFTENBETRAG_BRUTTO,
	GP_ID,
	WV_KZ,
	WV_GRUND_ID,
	VK_BRUTTO,
	VK_AKTION_BRUTTO,
	PV_SA_LOYALTY,
	PV_SA_NICHT_LOYALTY,
	PV_LOYALTY_BBY,
	PV_NICHT_LOYALTY_BBY,
	PV_KDN_BBY,
	PV_KDP_BBY,
	PV_LOYALTY_BON_BBY,
	PV_NICHT_LOYALTY_BON_BBY
) AS
-- SPEC0235522, prescherad, 09.04.2024, Neuanlage anlog AIS DE
SELECT
v01.mandant_id
,v01.wup_id
,v01.wup_abschrift_id
,v01.positionsnummer_id
,v01.abschriftart_id
,v01.nb_id
,v01.dat
,v01.woche_id
,CASE
WHEN v01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto > 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto > 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN v01.abschriftbetrag_netto > 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4)) END AS M_Absch_Menge
,CASE
WHEN v01.abschrift_menge_einh_id IS NULL AND v03.gewart_id = 'KG' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto < 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN v01.abschrift_menge_einh_id = 'G' AND v01.abschriftart_id <> '-1' AND v01.abschriftbetrag_netto < 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN v01.abschriftbetrag_netto < 0 THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4)) END AS M_Aufsch_Menge
,v01.art_id
-- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
,CASE WHEN v04.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
,v01.lastupd_dat
,CASE
WHEN v01.abschriftbetrag_netto > 0 THEN v01.abschriftbetrag_netto
ELSE 0 END AS abschriftbetrag_netto
,CASE
WHEN v01.abschriftbetrag_netto < 0 THEN v01.abschriftbetrag_netto
ELSE 0 END AS aufschriftbetrag_netto
,CASE
WHEN v01.abschriftbetrag_brutto > 0 THEN v01.abschriftbetrag_brutto
ELSE 0 END AS abschriftbetrag_brutto
,CASE
WHEN v01.abschriftbetrag_brutto < 0 THEN v01.abschriftbetrag_brutto
ELSE 0 END AS aufschriftbetrag_brutto
,COALESCE(v02.gp_id,-1) AS gp_id
,wv_kz
,wv_grund_id
,vk_brutto
,vk_aktion_brutto
--PV metrics
-- Splittung PV 
-- -> ab 01.04.2022 neue Logik davor alte Logik  
,CASE
WHEN v01.wv_grund_id = 2 AND v01.abschriftart_id = -1 THEN v01.abschriftbetrag_netto
ELSE 0 END AS pv_sa_loyalty
,CASE
WHEN v01.wv_grund_id = 0 AND v01.abschriftart_id = -1 THEN v01.abschriftbetrag_netto
ELSE 0 END AS pv_sa_nicht_loyalty

,CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (52, 53, 54) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
WHEN v01.wv_grund_id IN (52, 53, 54, 55) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
  ELSE 0 END AS pv_loyalty_bby
,CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (56, 57, 58) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
WHEN v01.wv_grund_id IN (56, 57, 58, 59) AND v01.abschriftart_id = -1
  THEN v01.abschriftbetrag_netto
  ELSE 0 END AS pv_nicht_loyalty_bby
,CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (60, 61, 62) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
WHEN v01.wv_grund_id IN (60, 61, 62, 63) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
  ELSE 0 END AS pv_kdn_bby
,CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (64, 65, 66) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
WHEN v01.wv_grund_id IN (64, 65, 66, 67) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
  ELSE 0 END AS pv_kdp_bby

,CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (55, 63, 67) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
  ELSE 0 END AS pv_loyalty_bon_bby
,CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (59) AND v01.abschriftart_id = -1 
  THEN v01.abschriftbetrag_netto
  ELSE 0 END AS pv_nicht_loyalty_bon_bby
  
FROM DBP_DATA.MARKTABSCHRIFTEN v01
LEFT JOIN
(SELECT
 art_id
,gp_id
,wup_id
,dat_von
,dat_bis
FROM DBP_DATA.ART_GP_NM_ZU_PER
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
FROM DBP_DATA.ART
WHERE mandant_id = 1
) v03

ON v01.art_id = v03.art_id

-- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
LEFT JOIN DBP_DATA.ART_PER v04
ON v01.art_id = v04.art_id
AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis
AND v01.mandant_id = v04.mandant_id

WHERE v01.mandant_id = 1

UNION ALL

SELECT
 v01.MANDANT_ID
,v01.WUP_ID
,v01.LAGERBEW_BELEG_ID
,v01.LAGERBEW_BELEG_POS_ID
,CASE 
WHEN v01.lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND v01.grund_id IN ('0020') THEN 210
WHEN v01.lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND v01.grund_id IN ('0027') THEN 211
WHEN v01.lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND v01.grund_id IN ('0026') THEN 212
WHEN v01.lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10') AND v01.grund_id IN ('0040') THEN 213
WHEN v01.lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') AND v01.grund_id IN ('0012') THEN 240
WHEN v01.lager_bewart_id IN ('V25','V26','V27','V28','W25','W26','W27','W28') AND v01.grund_id IN ('0051') THEN 241
WHEN v01.lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') AND v01.grund_id IN ('0029') THEN 242
END LAGER_BEWART_ID
,v01.NB_ID
,v01.DAT_BUCH
,CAST(CASE WHEN WEEK(v01.DAT_BUCH) < 10 
      THEN CONCAT(YEAR(v01.DAT_BUCH),'0',WEEK(v01.DAT_BUCH)) 
      ELSE CONCAT(YEAR(v01.DAT_BUCH),WEEK(v01.DAT_BUCH))END AS NUMBER(38,0))
,CASE WHEN v01.MENGE_LAGERBEW_BME < 0 THEN v01.MENGE_LAGERBEW_BME * -1 END
,CASE WHEN v01.MENGE_LAGERBEW_BME > 0 THEN v01.MENGE_LAGERBEW_BME * -1 END
,v01.ART_ID
-- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
,CASE WHEN v02.POSTEN_ID NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
,v01.DAT_BUCH
,CASE WHEN v01.BETRAG_VK_NETTO_VZ < 0 THEN CAST(v01.BETRAG_VK_NETTO_VZ AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1
,CASE WHEN v01.BETRAG_VK_NETTO_VZ > 0 THEN CAST(v01.BETRAG_VK_NETTO_VZ AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1
--,CAST(0 AS NUMBER(18,2))
,CASE WHEN v01.BETRAG_VERKAUF < 0 THEN CAST(v01.BETRAG_VERKAUF AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1
,CASE WHEN v01.BETRAG_VERKAUF > 0 THEN CAST(v01.BETRAG_VERKAUF AS NUMBER(18,2)) ELSE CAST(0 AS NUMBER(18,2)) END *-1
--,CAST(0 AS NUMBER(18,2))
,v01.GP_ID
,''
,CAST(v01.grund_id AS NUMBER(38,0))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
,CAST(0 AS NUMBER(18,2))
FROM DBP_DATA.LAGERBEW_DET v01

-- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
LEFT JOIN DBP_DATA.ART_PER v02
ON  v01.art_id = v02.art_id
AND v01.dat_buch BETWEEN v02.dat_von AND v02.dat_bis
AND v01.mandant_id = v02.mandant_id

WHERE v01.lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10','V25','V26','V27','V28','W25','W26','W27','W28',
                          'V50','V51','V52','V53','W50','W51','W52','W53','V54','V55','V56','V57','W54','W55','W56','W57')
AND v01.grund_id IN ('0020','0027','0026','0040','0012','0051','0029')
AND v01.mandant_id = 1;