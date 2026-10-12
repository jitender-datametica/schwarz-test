create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_SPANNE_WB_ARTBEW_2(
	RCV_ID,
	MANDANT_ID,
	SYSTEM_ID,
	BEWART_ID,
	NB_ID,
	ART_ID,
	DAT,
	MWST,
	BELASTUNGSART_ID,
	BELASTUNGSART_VD_ID,
	MENGE,
	EK_NETTO,
	VK_NETTO,
	VK_BRUTTO
) as
-- 20.07.2020 dsim: SPEC0064436 Artbew_2 view has been created
-- 20.04.2021 sanadze: AP0047531 Erstellung der View auf Snowflake
-- 14.06.2021 richternic: verdichtet Belastungsart_id aufnehmen
-- 30.06.2021 richternic: Anpassungen Brutto VK_2 
-- 08.02.2023 twie: SPEC0064436 ek_netto darf nicht durch menge geteilt werden, Gruppierung korrigiert
-- 01.03.2023 twie: SPEC0064436 ek_netto wird in der MV_SPANNE_WB_LBD_2 für Bewart_2 317-320 ausgefiltert, dafür hier als extra Feld hinzugenommen
-- 09.03.2023 twie: SPEC0064436 Sonderlogik vom 01.03.2023 entfernt, Tabelle enthält nicht die benötigten Daten
-- 12.04.2023 twie: SPEC0064436 andere Vorzeichenlogik in RPW gewünscht, deshalb bei allen Kennzahlen das Vorzeichen gedreht (* -1)

SELECT ab.wup_id AS rcv_id,  
 ab.mandant_id,
 7 AS system_id,
 ab.bewart_id,   
 ab.nb_id,  
 ab.art_id ,  
 ab.dat, 
 mp.mwst, 
 CAST(CASE WHEN ab.umsatz_netto >=0 THEN 251 
 ELSE 252 END AS CHAR(4))AS belastungsart_id, -- Belastungsart_id für Umsatz soll als 251 und Retouren 252 angegegeben werden
 4 AS belastungsart_vd_id, -- Belastungsart_id verdichtet (fuer das richtige Mapping mit der Lookup)
 SUM((ab.menge) * -1) AS menge,       --Menge (Hybridbericht)
 SUM((ab.ek_netto) * -1) AS ek_netto, --Betrag ek netto (Hybridbericht)
 SUM((ab.umsatz_netto) * -1) AS vk_netto,     -- Betrag VK_2 Netto (Hybridbericht)  
 SUM((ab.umsatz_netto * (1+(mp.mwst/100))) * -1) AS vk_brutto -- Betrag VK_2 Brutto (Hybritbericht)
FROM dbp_view.v_artbew_2 ab 

JOIN dbp_view.v_mwst_per_2 mp  
ON mp.mwst_id = ab.mwst_id  
AND mp.mandant_id = ab.mandant_id  
AND ab.dat BETWEEN mp.dat_von  
AND mp.dat_bis  

WHERE ab.mandant_id=1 

GROUP BY 1,2,3,4,5,6,7,8,9,10;
