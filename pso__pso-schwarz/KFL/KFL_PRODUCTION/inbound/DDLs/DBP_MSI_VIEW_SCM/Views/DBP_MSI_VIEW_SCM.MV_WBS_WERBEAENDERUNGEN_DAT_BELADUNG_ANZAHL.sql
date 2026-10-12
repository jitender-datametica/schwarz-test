CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_WERBEAENDERUNGEN_DAT_BELADUNG_ANZAHL(
	ART_ID,
	MANDANT_ID,
	DAT_AB,
	DAT_BIS,
	KJWO,
	AKTION_ID,
	OFFER_ID,
	WUP_ID_COUNT,
	ERSTELLUNGSDATUM,
	COUNT_NORMALPREISERHOEHUNG_FG,
	COUNT_WERBEAENDERUNG_NORMALPREISREDUKTION_FG,
	COUNT_WERBEAENDERUNG_ANGEBOTSPREISERHOEHUNG_FG,
	COUNT_WERBEAENDERUNG_ANGEBOTSPREISREDUKTION_FG,
	COUNT_WERBEAENDERUNG_ARTIKELENTFERNUNG_FG,
	COUNT_WERBEAENDERUNG_ARTIKELNEUANLAGE_FG,
	COUNT_WERBEAENDERUNG_MARKTANZAHLERHOEHUNG_FG,
	COUNT_WERBEAENDERUNG_MARKTANZAHLREDUKTION_FG,
	COUNT_WERBEAENDERUNG_RADIO_TV_BILLBOARD_FG,
	COUNT_WERBEAENDERUNG_ABBILDUNGSAENDERUNG_FG,
	COUNT_WERBEAENDERUNG_WERBETHEMA_FG,
	COUNT_WERBEAENDERUNG_SONSTIGES_FG,
	COUNT_WERBEAENDERUNG_KUNDENKARTE_PERSONALISIERT_FG
) AS
--2025-07-28, AP0275764, dknop, initial
--2025-08-25, dknop, adding ERSTELLUNGSDATUM
--2025-08-29, dknop, removing aktion_id, offer_if from ERDAT calculation
--2025-09-11, dknop, adding condition based on days to promo for Artikel IN count
--2025-09-24, dknop, correcting definition of artikelneuanlage_art_fg

WITH 
art_in_rank AS (SELECT DISTINCT v1.mandant_id, v1.aktion_id, v1.offer_id, v1.art_id, v1.dat_ab, v1.dat_bis, v1.dat_beladung,
ROW_NUMBER()OVER(PARTITION BY v1.mandant_id, v1.aktion_id, v1.offer_id, v1.art_id, v1.dat_ab, v1.dat_bis ORDER BY v1.dat_beladung ASC) AS rk FROM dbp_view.v_wbs_werbeaenderungen v1
GROUP BY v1.mandant_id, v1.aktion_id, v1.offer_id, v1.art_id, v1.dat_ab, v1.dat_bis, v1.dat_beladung),

erstellungsdatum AS (SELECT 
 wbs_w.art_id,wbs_w.mandant_id
,wbs_w.dat_ab
,wbs_w.dat_bis
,wbs_w.kjwo
,MIN (wbs_w.dat_beladung) AS erstellungsdatum
FROM dbp_view.v_wbs_werbeaenderungen wbs_w
GROUP BY
 wbs_w.art_id,wbs_w.mandant_id
,wbs_w.dat_ab
,wbs_w.dat_bis
,wbs_w.kjwo
 ),  
 
art_in_out AS (
SELECT 
 wbs_w.art_id
,wbs_w.mandant_id
,wbs_w.dat_ab
,wbs_w.dat_bis
,wbs_w.kjwo
,wbs_w.aktion_id
,wbs_w.offer_id 
,wbs_w.dat_beladung
,DATEDIFF('DAY', erstellungsdatum, wbs_w.dat_ab) days_to_promo
,SUM(wbs_w.werbeaenderung_artikelentfernung_fg) AS Anzahl_artikelentfernung
,SUM(wbs_w.werbeaenderung_artikelneuanlage_fg) AS Anzahl_artikelneuanlage
,COUNT(DISTINCT wbs_w.wup_id) AS wup_id_count_datb
,CASE WHEN (Anzahl_artikelneuanlage = wup_id_count_datb AND rk=1 AND days_to_promo<=42) OR (Anzahl_artikelneuanlage = wup_id_count_datb AND days_to_promo>42 AND rk<>1) THEN 1 ELSE 0 END AS artikelneuanlage_art_fg
,IFF(Anzahl_artikelentfernung = wup_id_count_datb, 1, 0) AS artikelentfernung_art_fg
FROM dbp_view.v_wbs_werbeaenderungen wbs_w
JOIN art_in_rank
ON wbs_w.art_id = art_in_rank.art_id
AND wbs_w.mandant_id = art_in_rank.mandant_id
AND wbs_w.dat_ab = art_in_rank.dat_ab
AND wbs_w.dat_bis = art_in_rank.dat_bis
AND wbs_w.aktion_id = art_in_rank.aktion_id
AND wbs_w.offer_id = art_in_rank.offer_id
AND wbs_w.dat_beladung = art_in_rank.dat_beladung

JOIN erstellungsdatum erdt
ON wbs_w.art_id = erdt.art_id
AND wbs_w.mandant_id = erdt.mandant_id
AND wbs_w.dat_ab = erdt.dat_ab
AND wbs_w.dat_bis = erdt.dat_bis
  
GROUP BY
wbs_w.art_id
 ,wbs_w.mandant_id
 ,wbs_w.dat_ab
 ,wbs_w.dat_bis
 ,wbs_w.kjwo
 ,wbs_w.aktion_id
 ,wbs_w.offer_id 
 ,wbs_w.dat_beladung
 ,rk
 ,erstellungsdatum
				 
)

 SELECT  DISTINCT
 wbs_w.art_id
,wbs_w.mandant_id
,wbs_w.dat_ab
,wbs_w.dat_bis
,wbs_w.kjwo
,wbs_w.aktion_id
,wbs_w.offer_id
,COUNT(DISTINCT wup_id) AS wup_id_count
,ed.erstellungsdatum
 ,CASE WHEN werbeaenderung_normalpreiserhoehung_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_normalpreiserhoehung_fg 
 ,CASE WHEN werbeaenderung_normalpreisreduktion_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_normalpreisreduktion_fg
 ,CASE WHEN werbeaenderung_angebotspreiserhoehung_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_angebotspreiserhoehung_fg
 ,CASE WHEN werbeaenderung_angebotspreisreduktion_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_angebotspreisreduktion_fg
 ,CASE WHEN artikelentfernung_art_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_artikelentfernung_fg
 ,CASE WHEN artikelneuanlage_art_fg = 1  THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_artikelneuanlage_fg
 ,CASE WHEN werbeaenderung_marktanzahlerhoehung_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_marktanzahlerhoehung_fg
 ,CASE WHEN werbeaenderung_marktanzahlreduktion_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_marktanzahlreduktion_fg
 ,CASE WHEN werbeaenderung_radio_tv_billboard_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_radio_tv_billboard_fg
 ,CASE WHEN werbeaenderung_abbildungsaenderung_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_abbildungsaenderung_fg
 ,CASE WHEN werbeaenderung_werbethema_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_werbethema_fg
 ,CASE WHEN werbeaenderung_sonstiges_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_sonstiges_fg
 ,CASE WHEN werbeaenderung_kundenkarte_personalisiert_fg = 1 THEN COUNT (DISTINCT wbs_w.dat_beladung) ELSE 0 END AS count_werbeaenderung_kundenkarte_personalisiert_fg

FROM dbp_view.v_wbs_werbeaenderungen wbs_w
JOIN art_in_out
ON wbs_w.art_id = art_in_out.art_id
AND wbs_w.mandant_id = art_in_out.mandant_id
AND wbs_w.dat_ab = art_in_out.dat_ab
AND wbs_w.dat_bis = art_in_out.dat_bis
AND wbs_w.aktion_id = art_in_out.aktion_id
AND wbs_w.offer_id = art_in_out.offer_id
AND wbs_w.dat_beladung = art_in_out.dat_beladung

JOIN erstellungsdatum ed
ON wbs_w.art_id = ed.art_id
AND wbs_w.mandant_id = ed.mandant_id
AND wbs_w.dat_ab = ed.dat_ab
AND wbs_w.dat_bis = ed.dat_bis
--AND wbs_w.aktion_id = ed.aktion_id
--AND wbs_w.offer_id = ed.offer_id

GROUP BY
  wbs_w.art_id
 ,wbs_w.mandant_id
 ,wbs_w.dat_ab
 ,wbs_w.dat_bis
 ,wbs_w.kjwo
 ,wbs_w.aktion_id
 ,wbs_w.offer_id
 ,ed.erstellungsdatum
 ,werbeaenderung_normalpreiserhoehung_fg
 ,werbeaenderung_normalpreisreduktion_fg
 ,werbeaenderung_angebotspreiserhoehung_fg
 ,werbeaenderung_angebotspreisreduktion_fg
 ,artikelentfernung_art_fg
 ,artikelneuanlage_art_fg
 ,werbeaenderung_marktanzahlerhoehung_fg
 ,werbeaenderung_marktanzahlreduktion_fg
 ,werbeaenderung_radio_tv_billboard_fg 
 ,werbeaenderung_abbildungsaenderung_fg 
 ,werbeaenderung_werbethema_fg 
 ,werbeaenderung_sonstiges_fg 
 ,werbeaenderung_kundenkarte_personalisiert_fg
;