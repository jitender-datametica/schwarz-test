create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_WANKO_BESCHAFFUNGSLOGISTIK_2(
	EMPFAENGER_TMS_GP_ID,
	ENTLADESTELLE_TMS_GP_ID,
	DAT_LIEF,
	TMS_AUFTRAG_ID,
	TMS_AUFTRAGSART_ID,
	MANDANT_ID,
	VERSENDER_TMS_GP_ID,
	BELADESTELLE_TMS_GP_ID,
	VORHOLSPEDITION_TMS_GP_TYP_CD,
	TMS_AUFTRAG_STATUS_CD,
	TMS_SORTIMENT_ID,
	GEWICHT_BRUTTO_KG,
	GEWICHT_NETTO_KG,
	ANZAHL_FLASCHEN,
	ABGELADENE_PALETTEN,
	ANZ_LT_AVIS,
	ANZ_STELLPLATZ,
	STPF_MISSING_FG,
	STAPELFAKTOR,
	ANZ_STELLPLATZ_BERECHNET,
	ABGELADENE_EPAL,
	AUFWAND,
	ERTRAG,
	ANZ_STELLPLATZ_HAUPTLAUF,
	ANZ_STELLPLATZ_VORLAUF,
	AUFWAND_HAUPTLAUF,
	AUFWAND_KORREKTUR,
	AUFWAND_VORLAUF,
	AUFWAND_FRACHT,
	AUFWAND_FIXPREIS,
	AUFWAND_WOCHENENDE,
	AUFWAND_ZEITFENSTER,
	AUFWAND_SONSTIGES,
	AUFWAND_LT,
	AUFWAND_AUFSETZEN,
	AUFWAND_MEHRAUFWAND,
	AUFWAND_UMSCHLAG,
	AUFWAND_DIESEL,
	ERTRAG_DIESEL,
	ERTRAG_FRACHT,
	ERTRAG_ZEITFENSTER,
	ERTRAG_SONSTIGES,
	ERTRAG_LT,
	ERTRAG_AUFSETZEN,
	ERTRAG_MEHRAUFWAND,
	ERTRAG_MAUT,
	ERTRAG_WOCHENENDE,
	ERTRAG_KORREKTUR,
	TMS_TOUR_ID,
	TRANSPORTATION_UNIT_ID_EXT,
	TMS_TOUR_BEZ,
	SYSTEM_ID,
	KJ_TRANSPORTATION_UNIT,
	TRANSPORTATION_UNIT_ID,
	TMS,
	DAT_TOUR,
	SPEDITION_TMS_GP_ID,
	SPOTAUFTRAG_FG,
	MANUELLE_DISPO_FG,
	ZIELLAGER_TMS_GP_ID,
	AUFTRAG_TXT_LIEFERSTEIN,
	AUFTRAG_TXT_BEMERKUNG_BELADEN,
	AUFTRAG_TXT_BEMERKUNG_ENTADEN,
	TEMPERATURGRUPPE_ID
) as















SELECT 
 tms_a.empfaenger_tms_gp_id
,tms_a.entladestelle_tms_gp_id
,tms_a.dat_lief
,tms_a.tms_auftrag_id
,tms_a.tms_auftragsart_id
,tms_a.mandant_id
,tms_a.versender_tms_gp_id
,tms_a.beladestelle_tms_gp_id
,CASE WHEN tms_a.vorholspedition_tms_gp_typ_cd = 'S' THEN 'Quellgebiet' ELSE 'Direkt' END AS vorholspedition_tms_gp_typ_cd
,tms_a.tms_auftrag_status_cd
,tms_a.tms_sortiment_id

,tms_a.gewicht_brutto_kg
,tms_a.gewicht_netto_kg

,tms_ad.anzahl_flaschen
,tms_av.abgeladene_paletten
,tms_ad.anz_lt_avis
,tms_a.anz_stellplatz


,COALESCE(tms_r.stpf_missing_fg,1)
,COALESCE(tms_r.stapelfaktor,1.000)
,tms_r.ANZ_STELLPLATZ_BERECHNET
,tms_av.abgeladene_epal
,tms_r.aufwand_gesamt
,tms_r.ertrag_gesamt
,0 AS anz_stellplatz_hauptlauf 
,0 AS anz_stellplatz_vorlauf
,tms_r.aufwand_hauptlauf
,tms_r.aufwand_korrektur
,tms_r.aufwand_vorlauf
,tms_r.aufwand_fracht
,tms_r.aufwand_fixpreis
,tms_r.aufwand_wochenende
,tms_r.aufwand_zeitfenster
,tms_r.aufwand_sonstiges
,tms_r.aufwand_lt
,tms_r.aufwand_aufsetzen
,tms_r.aufwand_mehraufwand
,tms_r.aufwand_umschlag
,tms_r.aufwand_diesel
,tms_r.ertrag_diesel
,tms_r.ertrag_fracht
,tms_r.ertrag_zeitfenster
,tms_r.ertrag_sonstiges
,tms_r.ertrag_lt
,tms_r.ertrag_aufsetzen
,tms_r.ertrag_mehraufwand
,tms_r.ertrag_maut
,tms_r.ertrag_wochenende
,tms_r.ertrag_korrektur
,tms_a.tms_tour_id 
,tms_t.transportation_unit_id_ext
,tms_t.tms_tour_bez
,tms_a.system_id
,YEAR(tms_a.dat_tour) AS KJ_transportation_unit
,TRY_CAST(TO_CHAR(tms_a.dat_tour, 'YYYYMMDD') || TO_CHAR(tms_a.tms_tour_id) AS NUMBER(38)) AS transportation_unit_id
,'WANKO' AS tms
,tms_a.dat_tour
,COALESCE(tms_t.spedition_tms_gp_id, '-1') AS spedition_tms_gp_id
,CASE WHEN tms_t.tms_tourtyp_id = '5' THEN  1 ELSE 0 END AS spotauftrag_fg
,CASE WHEN tms_t.tms_tour_strategisch_id IS NULL THEN 1 ELSE 0 END AS manuelle_dispo_fg
,tms_t.ziellager_tms_gp_id
,auftrag_txt_lieferstein
,auftrag_txt_bemerkung_beladen
,auftrag_txt_bemerkung_entaden
,CASE WHEN tms_a.temperaturgruppe_id = 1 THEN 'TK'
	  WHEN tms_a.temperaturgruppe_id = 2 THEN 'GK'
	  WHEN tms_a.temperaturgruppe_id = 3 THEN 'TE' ELSE 'UK' END AS temperaturgruppe_id

FROM dbp_view.v_tms_auftrag_2 tms_a

JOIN dbp_view.v_l_system_2 sys ON tms_a.system_id=sys.system_id AND sys.system_gruppe = 'WANKO BELOG'

LEFT JOIN dbp_view.v_tms_tour_2 tms_t
ON tms_a.dat_tour = tms_t.dat_tour

AND tms_a.tms_tour_id = tms_t.tms_tour_id
AND tms_a.system_id = tms_t.system_id

LEFT JOIN ( SELECT tms_auftrag_id , 
system_id
,SUM((CASE WHEN tms_av.tms_transportmittel_id  = 19 THEN tms_av.anz_verpackung  ELSE NULL END)) AS anzahl_flaschen
,SUM((CASE WHEN tms_av.tms_transportmittel_id  IN (1,2,5,8,9,10,12,15,18) THEN tms_av.anz_verpackung  ELSE NULL END)) AS abgeladene_paletten
,SUM((CASE WHEN tms_av.tms_transportmittel_id  = 8 THEN tms_av.anz_verpackung  ELSE NULL END)) AS abgeladene_epal
FROM dbp_view.v_tms_auftrag_verpackung_2 tms_av
GROUP BY tms_auftrag_id 
,system_id) tms_av
ON  tms_a.tms_auftrag_id = tms_av.tms_auftrag_id

AND tms_a.system_id = tms_av.system_id

LEFT JOIN (SELECT tms_auftrag_id , 
        system_id
		,SUM((CASE WHEN tms_ad.art_id  IS NULL AND tms_transportmittel_id IN (1,2,5,8,9,10,12,15,18) THEN tms_ad.anz_transportmittel  ELSE NULL END)) AS anz_lt_avis
       ,SUM((CASE WHEN tms_ad.art_id  IS NULL AND tms_transportmittel_id = 19 THEN tms_ad.anz_transportmittel  ELSE NULL END)) AS anzahl_flaschen
		FROM dbp_view.v_tms_auftrag_det_2 tms_ad
		GROUP BY tms_auftrag_id 
        ,system_id) tms_ad
		ON  tms_a.tms_auftrag_id = tms_ad.tms_auftrag_id
		
		AND tms_a.system_id = tms_ad.system_id 

LEFT JOIN ( 
	SELECT
	tms_r_sum.tms_ref_nr,
    tms_r_sum.system_id, tms_r_sum.tms_ref_unter_nr,  tms_r_sum.stpf_missing_fg, tms_r_sum.stapelfaktor,
	tms_r_sum.anz_stellplatz_berechnet,
	SUM(aufwand_fracht_) AS aufwand_fracht,
    SUM(aufwand_fixpreis_)AS aufwand_fixpreis,
	SUM(aufwand_diesel_) AS aufwand_diesel,
	SUM(aufwand_vorlauf_) AS aufwand_vorlauf,
	SUM(aufwand_umschlag_) AS aufwand_umschlag,
	SUM(aufwand_hauptlauf_) AS aufwand_hauptlauf,
    SUM(aufwand_korrektur_) AS aufwand_korrektur,
	SUM(aufwand_wochenende_) AS aufwand_wochenende,
	SUM(aufwand_zeitfenster_) AS aufwand_zeitfenster,
	SUM(aufwand_sonstiges_) AS aufwand_sonstiges,
	SUM(aufwand_lt_) AS aufwand_lt,
	SUM(aufwand_aufsetzen_) AS aufwand_aufsetzen,
	SUM(aufwand_mehraufwand_) AS aufwand_mehraufwand,
	SUM(ertrag_fracht_) AS ertrag_fracht,
	SUM(ertrag_diesel_) AS ertrag_diesel,
	SUM(ertrag_zeitfenster_) AS ertrag_zeitfenster,
	SUM(ertrag_sonstiges_) AS ertrag_sonstiges,
	SUM(ertrag_lt_) AS ertrag_lt,
	SUM(ertrag_aufsetzen_) AS ertrag_aufsetzen,
    SUM(ertrag_mehraufwand_) AS ertrag_mehraufwand,
    SUM(ertrag_maut_) AS ertrag_maut,
    SUM(ertrag_wochenende_) AS ertrag_wochenende,
    SUM(ertrag_korrektur_) AS ertrag_korrektur,
	COALESCE(AUFWAND_FRACHT,0) + COALESCE(AUFWAND_FIXPREIS,0) + COALESCE(AUFWAND_DIESEL,0) + COALESCE(AUFWAND_MEHRAUFWAND,0) + COALESCE(AUFWAND_VORLAUF,0) + COALESCE(AUFWAND_UMSCHLAG,0) + COALESCE(AUFWAND_HAUPTLAUF,0) + COALESCE(AUFWAND_WOCHENENDE,0) + COALESCE(AUFWAND_ZEITFENSTER,0) + COALESCE(AUFWAND_SONSTIGES,0) + COALESCE(AUFWAND_LT,0) + COALESCE(AUFWAND_AUFSETZEN,0)  + COALESCE(AUFWAND_KORREKTUR,0) AS AUFWAND_GESAMT,
	COALESCE(ERTRAG_FRACHT,0) + COALESCE(ERTRAG_DIESEL,0) + COALESCE(ERTRAG_ZEITFENSTER,0) + COALESCE(ERTRAG_SONSTIGES,0) + COALESCE(ERTRAG_LT,0) + COALESCE(ERTRAG_AUFSETZEN,0) + COALESCE(ERTRAG_MEHRAUFWAND,0) + COALESCE(ERTRAG_MAUT,0) + COALESCE(ERTRAG_WOCHENENDE,0) + COALESCE(ERTRAG_KORREKTUR,0) AS ERTRAG_GESAMT
	FROM
	(
		SELECT 
		COALESCE(tms_r.tms_ref_nr, tms_a.tms_auftrag_id) AS tms_ref_nr, 
        COALESCE(tms_r.system_id,tms_a.system_id) AS system_id, COALESCE(tms_r.tms_ref_unter_nr,tms_a.tms_auftrag_unter_id) AS tms_ref_unter_nr,  
		CASE WHEN stpf.anz_pal_stapelfaktor IS NULL THEN 1 ELSE 0 END AS stpf_missing_fg,
				
        COALESCE(CASE WHEN stpf.anz_pal_stapelfaktor = 0 THEN 1 ELSE stpf.anz_pal_stapelfaktor END, 1)   AS stapelfaktor,
	

    (CASE WHEN ZEROIFNULL(abgeladene_paletten_) > ZEROIFNULL(anz_lt_avis_) THEN abgeladene_paletten_  
    WHEN ZEROIFNULL(anz_lt_avis_) > 0 THEN anz_lt_avis_ ELSE anz_stellplatz END ) / stapelfaktor AS anz_stellplatz_berechnet,

    tms_r.tms_rech_beleg_id,tms_r.tms_rech_beleg_pos_id, COALESCE(abgeladene_epal_,0) AS abgeladene_epal,
		SUM(anz_stellplatz_berechnet) OVER (PARTITION BY 
        tms_r.system_id, tms_r.tms_rech_beleg_id,tms_r.tms_rech_beleg_pos_id) AS stp_,
		CASE WHEN COALESCE(stp_,0) = 0 THEN 1 ELSE stp_ END AS stp,
		SUM(abgeladene_epal)  OVER (PARTITION BY 
        tms_r.system_id, tms_r.tms_rech_beleg_id,tms_r.tms_rech_beleg_pos_id) AS epal,

		
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (1, 27)) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet  ELSE NULL END) AS aufwand_fracht_,
         (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 22) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet  ELSE NULL END) AS aufwand_fixpreis_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 7) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_diesel_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 9) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_vorlauf_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 10) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_umschlag_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 11) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_hauptlauf_,
         (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 13) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_korrektur_,
		 
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (3, 26)) THEN tms_r.betrag_netto/anz ELSE NULL END) AS aufwand_wochenende_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 5) THEN tms_r.betrag_netto/anz ELSE NULL END) AS aufwand_zeitfenster_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (15, 16, 17, 18, 19, 20, 21, 23)) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_sonstiges_,

         
         
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id IN (2, 24))  THEN (tms_r.betrag_netto/stp) * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_lt_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 4)  THEN (tms_r.betrag_netto/stp) * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_aufsetzen_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 1 AND tms_r.tms_konto_id = 8)  THEN (tms_r.betrag_netto/stp) * anz_stellplatz_berechnet ELSE NULL END) AS aufwand_mehraufwand_,
		 
		
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (1,27)) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_fracht_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 7) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_diesel_,
		 
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (5, 25)) THEN tms_r.betrag_netto/anz ELSE NULL END) AS ertrag_zeitfenster_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id  IN (15, 16, 17, 18, 19, 20, 21, 23)) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_sonstiges_,
		 
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (2, 24))  THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_lt_,
		 (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 4)  THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_aufsetzen_,

         (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 8) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_mehraufwand_,
         (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 6) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_maut_,
         (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id IN (3,26)) THEN tms_r.betrag_netto/anz ELSE NULL END) AS ertrag_wochenende_,
         (CASE WHEN (tms_r.tms_rech_beleg_typ_id = 0 AND tms_r.tms_konto_id = 12) THEN tms_r.betrag_netto/stp * anz_stellplatz_berechnet ELSE NULL END) AS ertrag_korrektur_
        
    
		FROM  dbp_view.v_tms_auftrag_2 tms_a

                   
        LEFT JOIN (SELECT 
				tms_ref_nr,
				tms_ref_unter_nr,
				
                r.system_id,
				r.tms_rech_beleg_id,
				rd.tms_rech_beleg_pos_id,
				tms_rech_beleg_typ_id,
				r.tms_rech_beleg_id || '_' || tms_rech_org_pos_id,
				COUNT (*) OVER (PARTITION BY 
                r.system_id, r.tms_rech_beleg_id,rd.tms_rech_beleg_pos_id) AS anz,
				tms_konto_id,
				betrag_netto,
				menge_frachtpflichtig

				FROM dbp_view.v_tms_rechnung_det_zu_2 dz

				LEFT JOIN dbp_view.v_tms_rechnung_2 r
				ON 
                dz.tms_rech_beleg_id = r.tms_rech_beleg_id 
				AND dz.system_id = r.system_id
				AND r.storno_fg = 0

				LEFT JOIN dbp_view.v_TMS_rechnung_det_2 rd
				ON 
                dz.tms_rech_beleg_id = rd.tms_rech_beleg_id
				AND dz.tms_rech_beleg_pos_id = rd.tms_rech_beleg_pos_id 
				AND dz.system_id = rd.system_id) tms_r

		ON  tms_a.tms_auftrag_id  = tms_r.tms_ref_nr  
		AND tms_a.tms_auftrag_unter_id  = tms_r.tms_ref_unter_nr  
		
		AND tms_a.system_id = tms_r.system_id   


		LEFT JOIN dbp_view.v_tms_gp_2 tms_b
		ON tms_a.mandant_id = tms_b.mandant_id 		AND 
        tms_a.system_id = tms_b.system_id
		AND tms_a.beladestelle_tms_gp_id = tms_b.tms_gp_id
		AND tms_a.beladestelle_tms_gp_typ_cd = tms_b.tms_gp_typ_cd

		LEFT JOIN (SELECT tms_auftrag_id , 
        system_id
		,SUM((CASE WHEN tms_av.tms_transportmittel_id  = 8 THEN tms_av.anz_verpackung  ELSE NULL END)) AS abgeladene_epal_
        ,SUM((CASE WHEN tms_av.tms_transportmittel_id IN (1,2,5,8,9,10,12,15,18) THEN tms_av.anz_verpackung  ELSE NULL END)) AS abgeladene_paletten_
		FROM dbp_view.v_tms_auftrag_verpackung_2 tms_av
		GROUP BY tms_auftrag_id 
        ,system_id) tms_av
		ON  tms_a.tms_auftrag_id = tms_av.tms_auftrag_id
		
		AND tms_a.system_id = tms_av.system_id

        LEFT JOIN (SELECT tms_auftrag_id , 
        system_id
		,SUM(CASE WHEN tms_ad.art_id  IS NULL AND tms_transportmittel_id IN (1,2,5,8,9,10,12,15,18) THEN tms_ad.anz_transportmittel  ELSE NULL END) AS anz_lt_avis_
       
		FROM dbp_view.v_tms_auftrag_det_2 tms_ad
        
		GROUP BY tms_auftrag_id 
        ,system_id) tms_ad
		ON  tms_a.tms_auftrag_id = tms_ad.tms_auftrag_id
		
		AND tms_a.system_id = tms_ad.system_id 

		LEFT JOIN dbp_view.v_GP_PLZ_BESCH_REGION_ZU_PER_2 stpf
		ON stpf.mandant_id = tms_b.mandant_id 		AND
        stpf.gp_id = TRY_CAST(tms_a.versender_tms_gp_id AS NUMBER)
		AND stpf.abholung_plz = tms_b.tms_gp_plz
		AND tms_a.dat_lief BETWEEN stpf.dat_von AND stpf.DAT_BIS

        

		) tms_r_sum

	GROUP BY tms_r_sum.tms_ref_nr 
    ,    tms_r_sum.system_id, tms_r_sum.tms_ref_unter_nr,  tms_r_sum.stpf_missing_fg, tms_r_sum.stapelfaktor, tms_r_sum.anz_stellplatz_berechnet

	) tms_r

ON  tms_a.tms_auftrag_id = tms_r.tms_ref_nr
AND tms_a.tms_auftrag_unter_id = tms_r.tms_ref_unter_nr

AND tms_a.system_id = tms_r.system_id

LEFT JOIN (SELECT
 tms_at.tms_auftrag_id
,tms_at.system_id
,LISTAGG(auftrag_txt ,'; ') AS auftrag_txt_lieferstein
FROM dbp_view.v_tms_auftrag_text_2 tms_at
WHERE tms_at.tms_text_typ_cd  = 'L'
GROUP BY tms_at.tms_auftrag_id, tms_at.system_id) l_lieferstein
ON tms_a.tms_auftrag_id = l_lieferstein.tms_auftrag_id
AND tms_a.system_id = l_lieferstein.system_id
LEFT JOIN (SELECT
 tms_at.tms_auftrag_id
,tms_at.system_id
,LISTAGG(auftrag_txt ,'; ') AS auftrag_txt_bemerkung_beladen
FROM dbp_view.v_tms_auftrag_text_2 tms_at
WHERE tms_at.tms_satzart_id = 135
GROUP BY tms_at.tms_auftrag_id, tms_at.system_id) l_bemer_bel
ON tms_a.tms_auftrag_id = l_bemer_bel.tms_auftrag_id
AND tms_a.system_id = l_bemer_bel.system_id
LEFT JOIN (SELECT
 tms_at.tms_auftrag_id
,tms_at.system_id
,LISTAGG(auftrag_txt ,'; ') AS auftrag_txt_bemerkung_entaden
FROM dbp_view.v_tms_auftrag_text_2 tms_at
WHERE tms_at.tms_satzart_id = 136
GROUP BY tms_at.tms_auftrag_id, tms_at.system_id) l_bemer_ent
ON tms_a.tms_auftrag_id = l_bemer_ent.tms_auftrag_id
AND tms_a.system_id = l_bemer_ent.system_id
;
