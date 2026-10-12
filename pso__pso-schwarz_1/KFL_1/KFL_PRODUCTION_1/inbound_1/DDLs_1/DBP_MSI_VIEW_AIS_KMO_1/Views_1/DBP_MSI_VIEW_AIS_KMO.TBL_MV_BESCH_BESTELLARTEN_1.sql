CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_BESCH_BESTELLARTEN_1(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	LOESCH_FG_EKPO,
	MENGE_BEST_BME,
	MENGE_BEST_KOLLI,
	MENGE_BEST,
	DAT_BEST_BELEG,
	WRG_ID,
	GP_ID,
	BESTELLART_ID,
	LAGER_BEWART_ID,
	DAT_BUCH,
	ENDLIEF_FG,
	DAT_LIEF_WUNSCH,
	DAT_LIEF_BEWERTUNG,
	MENGE_LIEF_IST_KOLLI,
	ANFORDERER_NAME,
	BETRAG_BEST_EK_N,
	BETRAG_LAGERBEW_EK_N,
	UMRECHNUNGSKURS_AKT,
	UMRECHNUNGSKURS_HIST
) 
 AS 
   SELECT
   t1.mandant_id,
   t1.best_beleg_id,
   t1.best_beleg_pos_id,
   t1.art_id,
   t1.wup_id,
   t1.nb_id,
   t1.lagerort_id,
   t1.loesch_fg_ekpo,
   CASE WHEN t1.endlief_fg = 1 THEN t1.menge_best_bme *-1 ELSE t1.menge_best_bme END AS menge_best_bme,
   CASE WHEN t1.endlief_fg = 1 THEN t1.menge_lief_soll_kolli *-1 ELSE t1.menge_lief_soll_kolli END AS menge_best_kolli,
   CASE WHEN t1.endlief_fg = 1 THEN t1.menge_lief *-1 ELSE t1.menge_lief END AS menge_best,
   t1.dat_best_beleg,
   t1.wrg_id,
   t1.gp_id,
   t1.bestellart_id,
   t1.lager_bewart_id,
   -- Anpassung für Snowflake: lager_bewart_id hat VARCHAR()-Datentyp
   CASE WHEN t1.lager_bewart_id IN ('101', '162', '901') THEN   t1.dat_buch END AS dat_buch,
   t1.endlief_fg,
   t1.dat_lief_wunsch,
   t1.dat_lief_bewertung,
   t1.menge_lief_ist_kolli,
   t4.anforderer_name,
   t1.betrag_best_ek_n,
   t1.betrag_lagerbew_ek_n,
   v300.umrechnungskurs,
   v400.umrechnungskurs
   FROM dbp_view.v_besch_best_lief_lbs_1 t1_1
   
   /*-- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs_1 t3
   ON t1.dat_best_beleg BETWEEN t3.dat_von AND t3.dat_bis
   AND t1.wrg_id = t3.von_wrg_id
   AND t3.kurstyp_id = 9
   AND t3.nach_wrg_id ='EUR'*/

    -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v300
   ON v300.dat_bis = '9999-12-31'
   AND t1.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v400
   ON t1.dat_best_beleg BETWEEN v400.dat_von AND v400.dat_bis
   AND t1.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   
   LEFT OUTER JOIN dbp_view.v_besch_best_det_1 t4
   ON t1.mandant_id = t4.mandant_id
   AND t1.best_beleg_id = t4.best_beleg_id
   AND t1.best_beleg_pos_id = t4.best_beleg_pos_id
   AND t1.dat_best_beleg = t4.dat_best_beleg
   WHERE t1.mandant_id <> 1;