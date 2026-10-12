CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_DET_2(
	MANDANT_ID,
	SYSTEM_ID,
	NB_ID,
	TOUR_POS_ID,
	WUP_ID,
	TOUR_ID,
	MANDANT_ID_KUNDE,
	REIHENFOLGE_TOUR_DISPO,
	LAGERNUMMER_ID,
	KUNDE_ID,
	LIEF_BELEG_ID,
	ANZAHL_STOPPS,
	KJ_LIEF_BELEG
) AS
-- 10.08.2016,srom: AP0002648 - Anlieferpünktlichkeit, Feld zeit_plan_ankunft jetzt in tour_det_zlv_vttkl_2
-- 24.10.2016 twie: AP0014554 Workaround: to_number Fuktion, da kunde_id auch Buchstaben enthalten kann
-- 02.11.2016 srom: AP0006317, SPEC0013463 tour_det.loesch_fg=0 einschränken
-- 05.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
--2024-01-31, INC7963291, dknop, change kunde_id 
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

   SELECT
    td.mandant_id, 
    td.system_id, 
    td.nb_id, 
    tour_pos_id, 
    td.wup_id, 
    td.tour_id, 
    CASE WHEN mandant_id_kunde IS NULL OR mandant_id_kunde = 0 THEN td.mandant_id ELSE mandant_id_kunde END AS mandant_id_kunde, 
    td.reihenfolge_tour_dispo,
    td.lagernummer_id, 
     --CASE WHEN TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) END AS kunde_id_
    CASE WHEN TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN -3 ELSE w.aktuell_wup_id END kunde_id_,
    lief_beleg_id, 
    CASE WHEN ((COALESCE(TRY_TO_NUMBER(kunde_id_),0)) - (SUM(COALESCE(TRY_TO_NUMBER(kunde_id_),0)) OVER (PARTITION BY td.mandant_id, td.wup_id, td.tour_id ORDER BY 
                                                                                                          COALESCE(TRY_TO_NUMBER(kunde_id_),0) ASC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) <> 0
   OR
   (SUM(COALESCE(TRY_TO_NUMBER(kunde_id_),0)) OVER (PARTITION BY td.mandant_id, td.wup_id, td.tour_id ORDER BY COALESCE(TRY_TO_NUMBER(kunde_id_),0) ASC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) IS NULL)
   THEN 1 ELSE 0 END AS anzahl_stopps,
   kj_lief_beleg
   
   FROM
   dbp_view.v_tour_det_2 td
   INNER JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN td.mandant_id_kunde IS NULL OR td.mandant_id_kunde = 0 THEN td.mandant_id ELSE td.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))
  WHERE loesch_fg = 0
  AND (kj_lief_beleg = -1 OR kj_lief_beleg >= YEAR(CURRENT_TIMESTAMP) - 2);