create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_SPANNE_WB_MA_2(
	RCV_ID,
	NB_ID,
	DAT,
	MANDANT_ID,
	SYSTEM_ID,
	ART_ID,
	BELASTUNGSART_ID,
	BELASTUNGSART_VD_ID,
	WRG_ID,
	BEZUGSWEG_ID,
	OWG_ID,
	ABSCH_MENGE,
	AUFSCH_MENGE,
	EK_NETTO,
	VK_NETTO,
	VK_BRUTTO
) as
-- 20.07.2020 dsim: SPEC0064436 Abschriften_2 view has been created
-- 20.04.2021 sanadze: AP0047531 Erstellung der View auf Snowflake
-- 14.06.2021 richternic: verdichtet Belastungsart_id aufnehmen
-- 19.01.2022 prescherad: SPEC0140144 Umbau auf 1:n Logik für EK Preise
-- 07.02.2022 prescherad: SPEC0140144 Trennung von Abschriten auf Abschriften_2 und Aufschriften
-- 21.12.2022 twie: SPEC0064436 Logik aus AIS_DE übernommen für Untercheidung KG / Gramm bei Absch_Menge und Aufsch_Menge
-- 11.01.2023 twie: SPEC0064436 Kennzahlen Absch_Menge, Aufsch_Menge und ek_netto sollen bei abschriftart_id < 100 keinen Wert ausgeben
--					dafür die Definition aus AIS_DE für Absch_Menge, Aufsch_Menge angepasst
-- 12.04.2023 twie: SPEC0064436 andere Vorzeichenlogik in RPW gewünscht, deshalb bei allen Kennzahlen das Vorzeichen gedreht (* -1)
-- 21.11.2023 prescherad: SPEC0211574, Anpassung EK Preisfindungslogik
-- 24.11.2023 prescherad: SPEC0211574, ek_netto durch ek_netto_bnk ersetzt und mit Abschriftenmenge gewichtet
-- 18.01.2024 prescherad: SPEC0211574, Vorzeichenlogik für Aufschriften positiv für Abschriften_2 negativ
-- 24.04.2024 prescherad; SPEC0211574, Sonderlogik für Pfand OWG 1092 einbauen
-- 30.04.2024 prescherad; SPEC0211574, Pfandartikel aus OWG 1092 VK_2 Preis nicht mit Menge bewerten
-- 28.05.2024 prescherad; SPEC0211574, EK Preis mit Komponentenmenge multipilizieren und Anpassung Aggregationsfunktion von Sum zu Avg bei EK

SELECT ma.wup_id AS rcv_id, 
 ma.nb_id, 
 ma.dat,
 ma.mandant_id, 
  7 AS system_id,
 ma.art_id, 
 CAST(ma.abschriftart_id AS CHAR(4)) AS  belastungsart_id,
 -- verdichtet ID -- wenn abschriftart_id 8,99,100 dann 3 alles andere 2
 CASE WHEN ma.abschriftart_id  IN (8,99,190) THEN 3 ELSE 2 END AS belastungsart_vd_id, 
 ma.wrg_id,
 ek_mapping.bezugsweg_id,
 owg.owg_id,
 
SUM((CASE
WHEN ma.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND ma.abschriftart_id >= 100 AND ma.abschriftbetrag_netto > 0 THEN CAST (ma.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN ma.abschrift_menge_einh_id = 'G' AND ma.abschriftart_id >= 100 AND ma.abschriftbetrag_netto > 0 THEN CAST (ma.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN ma.abschriftbetrag_netto > 0 AND ma.abschriftart_id >= 100 THEN CAST (ma.menge_abschrift  AS DECIMAL(13,4)) ELSE 0 END) * -1) AS Absch_Menge,
SUM(CASE
WHEN ma.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND ma.abschriftart_id >= 100 AND ma.abschriftbetrag_netto < 0 THEN CAST (ma.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN ma.abschrift_menge_einh_id = 'G' AND ma.abschriftart_id >= 100 AND ma.abschriftbetrag_netto < 0 THEN CAST (ma.menge_abschrift  AS DECIMAL(13,4))/ 1000
WHEN ma.abschriftbetrag_netto < 0 AND ma.abschriftart_id >= 100 THEN CAST (ma.menge_abschrift  AS DECIMAL(13,4)) ELSE 0 END *-1)   AS Aufsch_Menge,

 CASE WHEN owg.owg_id != 1092 AND ek_mapping.bezugsweg_id = 1  
 THEN 
 (Absch_Menge+Aufsch_Menge)*AVG((CASE WHEN ma.abschriftart_id >= 100 THEN ek_gp.ek_netto_bnk * ek_gp.komponentenmenge ELSE 0 END ))
 WHEN owg.owg_id != 1092 AND ek_mapping.bezugsweg_id != 1
 THEN(Absch_Menge+Aufsch_Menge)*AVG((CASE WHEN ma.abschriftart_id >= 100 THEN COALESCE(ek_vz.ek_netto_bnk,ek_gp.ek_netto_bnk) * COALESCE(ek_vz.komponentenmenge,ek_gp.komponentenmenge) ELSE 0 END )) 
 ELSE  
 SUM((CASE WHEN ma.abschriftart_id >=100 THEN ma.abschriftbetrag_brutto ELSE 0 END))*-1
 END AS ek_netto, 

 SUM((ma.abschriftbetrag_netto) * -1) vk_netto,   
 SUM((ma.abschriftbetrag_brutto) * -1) vk_brutto  
 
 FROM dbp_view.v_marktabschriften_2 ma
 
 LEFT JOIN dbp_data.art_wg_zu_per_2 wg
 ON ma.mandant_id = wg.mandant_id 
 AND ma.art_id = wg.art_id
 AND ma.dat BETWEEN wg.dat_von AND wg.dat_bis
 AND arthiertyp_id = 2

 JOIN dbp_data.wg_per_2 owg
 ON ma.mandant_id = owg.mandant_id 
 AND wg.wg_id = owg.wg_id
 AND ma.dat BETWEEN owg.dat_von AND owg.dat_bis
 
 JOIN dbp_view.v_art_gp_nm_zu_per_2 ek_mapping         
 ON ma.mandant_id=ek_mapping.mandant_id
 AND ma.art_id=ek_mapping.art_id       
 AND ma.wup_ID=ek_mapping.wup_ID
 AND ma.dat BETWEEN ek_mapping.dat_von AND ek_mapping.dat_bis

 LEFT OUTER JOIN  dbp_view.v_art_gp_wup_zu_per_2 ek_vz          
 ON ek_mapping.mandant_id=ek_vz.mandant_id 
 AND ek_mapping.art_id=ek_vz.art_id         
 AND ek_mapping.gp_id=ek_vz.gp_id
 AND ma.dat BETWEEN ek_vz.dat_von AND ek_vz.dat_bis
 --ermittelt den auf VZ Ebene güliten EK Preis, Lieferung über Verteilzentrum 
 AND ek_mapping.vz_wup_id = ek_vz.wup_id
 AND ek_vz.wup_id > -1
 
 LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_2 ek_gp          
 ON ek_mapping.mandant_id=ek_gp.mandant_id 
 AND ek_mapping.art_id=ek_gp.art_id         
 AND ek_mapping.gp_id=ek_gp.gp_id
 AND ma.dat BETWEEN ek_gp.dat_von AND ek_gp.dat_bis
  --ermittelt den denzetralen EK_Preis, Direktlieferung von Lieferant an Filiale 
 AND ek_gp.wup_id = -1 
 

 INNER JOIN
 (SELECT
 art_id
 ,gewart_id
 FROM dbp_view.v_art_2
 WHERE mandant_id = 1
 ) art_2
 ON ma.art_id = art.art_id

WHERE ma.mandant_id=1 

GROUP BY 1,2,3,4,5,6,7,8,9,10,11;
