create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WBS_ART_WUP_AKTION_INITIAL(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID_VZ,
	WUP_ID_VZ,
	NB_ID_VZ,
	AKTION_ID,
	AUSLIEFERGRUPPE_ID,
	DAT_VON,
	DAT_BIS,
	DAT_BELADUNG,
	OFFER_ID,
	ANGEBOT_ID,
	WBS_PHASE_ID,
	BEST_GENERIERT_FG,
	BESTELLUNG_LIEFERANT_FG,
	STILLE_AKTION_FG,
	TV_FG,
	GK_FG,
	WERBEAENDERUNG_ARTIKELNEUANLAGE_FG,
	WERBEAENDERUNG_ARTIKELENTFERNUNG_FG,
	ANTEIL_WUP_ARTIKEL_PERC,
	ANZ_TAGE_WERBUNG,
	BEDARF_BME,
	BEDARF_AME,
	BESTELLUNG_LIEFERANT_MENGE,
	UEBERTRAGUNGS_FG,
	BESTELLMENGE_FINAL_AME,
	BESTELLMENGE_OHNE_BESTAND_AME,
	MENGE_MINDESTPLATZIERUNG_BME,
	PROGNOSE_WERBEZEITRAUM_BME,
	PROJIZIERTER_BESTAND_VOR_WERBUNG_BME,
	WERBUNG_IN_X_TAGEN,
	ZIELBESTAND_BME,
	INIT_BELIEFERUNG_FG,
	DAT_BESTANDSPERIODE_REL,
	DAT_LIEF_SPLIT,
	DAT_LIEF_WUNSCH,
	DAT_BESTANDSPERIODE_BIS,
	DAT_LETZTE_NACHVERSORGUNG,
	WE_BEARBEITUNGSZEIT,
	MENGE_GESAMT_BME,
	MENGE_MIN_BME,
	MENGE_INITIAL_BME,
	MENGE_INITIAL_AME,
	MENGE_INITIAL_PAL,
	SPLIT_FG,
	KJWO,
	FAIR_SHARE_FG,
	ORDER_TYPE,
	INIT_LIEF_MODUS_KZ
) as













WITH TOP_DAT_BERECHNUNG AS (
                SELECT  DISTINCT TOP 5 dat_beladung 
        FROM dbp_view.v_wbs_werbeaenderungen ORDER BY  dat_beladung DESC) 

SELECT 
	v00.mandant_id
	, v00.art_id
	
    
	, v05.aktuell_wup_id wup_id 
	, v00.nb_id
	, CASE WHEN v00.wup_id_vz = 6140 THEN 4 ELSE v00.mandant_id_vz END AS mandant_id_vz 
	, v00.wup_id_vz
	, v00.nb_id_vz
	, v00.aktion_id
	, v00.ausliefergruppe_id
	, v00.dat_ab AS dat_von
	, v00.dat_bis
    , v00.dat_beladung
    
	, v00.offer_id
    , v03.angebot_id 
	, v00.wbs_phase_id
	, v00.best_generiert_fg
    , v00.bestellung_lieferant_fg 
    , v00.stille_aktion_fg                                                                                   
    , v00.tv_fg
    , v00.gk_fg
    , v00.werbeaenderung_artikelneuanlage_fg
    , v00.werbeaenderung_artikelentfernung_fg
    , v00.anteil_wup_artikel_perc
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.anz_tage_werbung ELSE 0 END AS anz_tage_werbung
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.bedarf_bme ELSE 0 END AS bedarf_bme
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.bedarf_ame ELSE 0 END AS bedarf_ame
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.bestellung_lieferant_menge ELSE 0 END AS bestellung_lieferant_menge 
	
    , CASE WHEN v00.bestellung_lieferant_menge = 0 OR v00.bestellung_lieferant_menge IS NULL THEN 0 ELSE 1 END AS uebertragungs_fg 
    , 0 AS bestellmenge_final_ame 
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.bestellmenge_ohne_bestand_ame ELSE 0 END AS bestellmenge_ohne_bestand_ame 
																
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.menge_mindestplatzierung_bme  ELSE 0 END AS menge_mindestplatzierung_bme 
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.prognose_werbezeitraum_bme ELSE 0 END AS prognose_werbezeitraum_bme
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.projizierter_bestand_vor_werbung_bme ELSE 0 END AS projizierter_bestand_vor_werbung_bme
    , (v00.dat_beladung - v00.dat_ab) AS werbung_in_x_tagen
    , CASE WHEN v03.angebot_id=v00.offer_id THEN v00.zielbestand_bme ELSE 0 END AS zielbestand_bme
    
	
    , CASE WHEN v01.art_id IS NOT NULL THEN 1 ELSE 0 END AS init_belieferung_fg  
	, v01.dat_bestandsperiode_rel
	, v01.dat_lief_split
	, v01.dat_lief_wunsch
	, v01.dat_bestandsperiode_bis
	, v01.dat_letzte_nachversorgung
	, v01.we_bearbeitungszeit
	, CASE WHEN v03.angebot_id=v00.offer_id THEN v01.menge_gesamt_bme ELSE 0 END AS menge_gesamt_bme
	, CASE WHEN v03.angebot_id=v00.offer_id THEN v01.menge_min_bme ELSE 0 END AS menge_min_bme
	, CASE WHEN v03.angebot_id=v00.offer_id THEN v01.menge_initial_bme ELSE 0 END AS menge_initial_bme
	, CASE WHEN v03.angebot_id=v00.offer_id THEN v01.menge_initial_ame ELSE 0 END AS menge_initial_ame
	, CASE WHEN v03.angebot_id=v00.offer_id THEN v01.menge_initial_pal ELSE 0 END AS menge_initial_pal
	, v01.split_fg
	
	, v02.kjwo
	
	, v01.fair_share_fg
	, v01.order_type
    , COALESCE(v01.init_lief_modus_kz,'S')

FROM 
dbp_view.v_wbs_werbeaenderungen v00
INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v00.mandant_id
   
  AND v05.wup_id = v00.wup_id
  AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

JOIN dbp_view.v_pmr_angebot_art_wup_zu v03
ON v00.mandant_id = v03.mandant_id 
AND v00.art_id = v03.art_id
AND v00.wup_id = v03.wup_id
AND v00.nb_id = v03.nb_id
AND v00.dat_ab = v03.dat_von
AND v00.dat_bis = v03.dat_bis
        
JOIN TOP_DAT_BERECHNUNG v99
ON v00.dat_beladung = v99.dat_beladung

LEFT JOIN dbp_view.v_wbs_art_wup_aktion_initial v01
ON v00.mandant_id = v01.mandant_id
AND v00.art_id = v01.art_id
AND v00.wup_id = v01.wup_id
AND v00.nb_id = v01.nb_id
AND v00.wup_id_vz = v01.wup_id_vz
AND v00.nb_id_vz = v01.nb_id_vz
AND v00.aktion_id = v01.aktion_id
AND v00.ausliefergruppe_id = v01.ausliefergruppe_id
AND v00.dat_ab = v01.dat_von
AND v00.dat_bis = v01.dat_bis
AND v00.dat_beladung = v01.dat_beladung


JOIN dbp_view.v_tag v02
ON (v00.dat_ab = v02.dat);