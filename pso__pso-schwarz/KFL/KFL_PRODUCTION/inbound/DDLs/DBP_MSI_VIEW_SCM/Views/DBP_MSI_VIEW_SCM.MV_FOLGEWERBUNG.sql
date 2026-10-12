CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_FOLGEWERBUNG (
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	KJWO,
	KJWO_WERBUNG,
	AKTION_THEMA_ID_FOLGEWERBUNG,
	AKTION_THEMA_BEZ_FOLGEWERBUNG,
	KJWO_NAECHSTE_FOLGEWERBUNG,
	KJWO_LETZTE_FOLGEWERBUNG
) AS
--20220929 dknop: AP0135037_SPEC0157981 adding avq_relevant_fg  = 1
--20221028, dknop, changing to COALESCE(wkw.avq_relevant_fg,1)
--20231122, nwag, limit to last 2 yrs - cost opt.
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
 SELECT wkw.mandant_id, 
-- wkw.wup_id, 
--CASE WHEN TRY_CAST(wkw.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id,
 v05.aktuell_wup_id wup_id,
 0 AS nb_id, wkw.art_id, wkw.kjwo, wkw.kjwo AS kjwo_werbung,
   aktion_thema_id AS aktion_thema_id_folgewerbung,
   aktion_thema_bez AS aktion_thema_bez_folgewerbung,
   MIN(akt.kjwo_von) AS kjwo_naechste_folgewerbung,  MAX(akt.kjwo_von) AS kjwo_letzte_folgewerbung
   FROM dbp_view.v_werbung_kennzahlen_woche wkw
   
   INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = wkw.mandant_id 
  -- AND v05.wup_id = CASE WHEN TRY_CAST(wkw.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(wkw.wup_id AS INTEGER) END
   AND v05.wup_id = wkw.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

   LEFT OUTER JOIN (SELECT aaw.mandant_id, aaw.wup_id, aaw.art_id, COALESCE( ats.aktion_thema_id,'0') aktion_thema_id, COALESCE( ats.aktion_thema_bez, 'N/A') aktion_thema_bez, a.kjwo_von
   FROM dbp_view.v_aktion_art_wup_zu aaw
   JOIN dbp_view.v_aktion a
   ON a.mandant_id=aaw.mandant_id AND a.aktion_id=aaw.aktion_id
   LEFT OUTER JOIN dbp_view.v_aktion_thema_spr_zu ats
   ON aaw.mandant_id=ats.mandant_id AND aaw.aktion_thema_id=ats.aktion_thema_id
   ) akt
   ON  wkw.mandant_id=akt.mandant_id AND wkw.art_id=akt.art_id AND wkw.wup_id=akt.wup_id AND wkw.kjwo<akt.kjwo_von
   WHERE COALESCE(wkw.avq_relevant_fg,1)=1 
   AND wkw.kjwo IN (SELECT kjwo FROM dbp_view.v_tag WHERE akt_kj BETWEEN -2 AND 1 GROUP BY kjwo)
   GROUP BY 1,2,3,4,5,6,7,8;