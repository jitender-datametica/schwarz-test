CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_AS_FOOD_GESAMT_1(
	ART_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT_AUSLISTUNG,
	PHASE_ID,
	KJWO,
	PHASE_WO,
	PHASE_VK_BRUTTO,
	PHASE_VK_NETTO,
	GP_ID,
	PHASE_STATUS,
	ERL_FG,
	DAT_FINAL,
	ERL_KZ,
	DAT_AEND,
	MENGE_ABSCHRIFT_22,
	ABSCHRIFTBETRAG_NETTO_22,
	MENGE_ABSCHRIFT_122,
	ABSCHRIFTBETRAG_NETTO_122,
	MENGE_ENDBESTAND_PHASE,
	VK_MENGE,
	UMSATZ_NETTO,
	BETRAG_EK_NETTONETTO,
	BETRAG_EK_MEP,
	BETRAG_EINSTANDSPREIS,
	BETRAG_LOGKOSTENZUSCHLAG,
	BETRAG_EK_MEP_VOR_FWU,
	MENGE_STARTBESTAND,
	VK_NETTO,
	VK_NETTO_START_BESTAND,
	MENGE_ENDBESTAND,
	PHASE_ID_MAX_VK_BRUTTO
) AS
   SELECT
   v01.art_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id,
   v01.dat_auslistung,
   v01.phase_id,
   v01.kjwo,
   v01.phase_wo,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.phase_vk_brutto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.phase_vk_brutto END AS phase_vk_brutto,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.phase_vk_netto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.phase_vk_netto END AS phase_vk_netto,
   v02.gp_id,
   v02.phase_status,
   v02.erl_fg,
   v02.dat_final,
   v02.erl_kz,
   v02.dat_aend,
   v01.menge_preisabschrift AS menge_abschrift_22,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_preisabschrift_netto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_preisabschrift_netto END AS abschriftbetrag_netto_22,
   v01.menge_totalabschrift AS menge_abschrift_122,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_totalabschrift_netto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_totalabschrift_netto END AS abschriftbetrag_netto_122,
   v01.menge_endbestand_phase,
   v01.menge_absatz AS vk_menge,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.umsatz_netto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.umsatz_netto END AS umsatz_netto,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_ek_nettonetto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_ek_nettonetto END AS betrag_ek_nettonetto,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_ek_mep * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_ek_mep END AS betrag_ek_mep,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_einstandspreis * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_einstandspreis END AS betrag_einstandspreis,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_logkostenzuschlag * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_logkostenzuschlag END AS betrag_logkostenzuschlag,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v01.betrag_ek_mep_vor_fwu * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v01.betrag_ek_mep_vor_fwu END AS betrag_ek_mep_vor_fwu,  
   ZEROIFNULL(v04.menge_startbestand) AS menge_startbestand,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(v04.vk_netto * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE v04.vk_netto END AS vk_netto_converted,
   v04.menge_startbestand * vk_netto_converted AS vk_netto_start_bestand,
   ZEROIFNULL(v05.menge_endbestand) AS menge_endbestand,
   CASE
   WHEN v2.wrg_typ_id = 0 THEN CAST(FIRST_VALUE(v01.phase_vk_brutto) OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.wup_id, v01.nb_id, v01.dat_auslistung ORDER BY v01.phase_id DESC) * v03.umrechnungskurs AS NUMBER(38,4))
   ELSE FIRST_VALUE(v01.phase_vk_brutto) OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.wup_id, v01.nb_id, v01.dat_auslistung ORDER BY v01.phase_id DESC) END AS PHASE_ID_MAX_VK_BRUTTO,

  FROM dbp_view.v_as_food_det_1 v01
   JOIN dbp_view.v_as_food_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND  v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id
   AND v01.dat_auslistung = v02.dat_auslistung

    
    LEFT JOIN (

     SELECT 
     v02.mandant_id
     ,v02.art_id
     ,v02.wup_id
     ,v02.nb_id
     ,v02.dat_auslistung
     ,v01.phase_id
     ,v02.menge_startbestand
     ,v02.vk_netto
     ,MIN(v01.kjwo) AS kjwo
     
     FROM dbp_view.v_as_food_det_1 v01
     
   JOIN dbp_view.v_as_food_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND  v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id
   AND v01.dat_auslistung = v02.dat_auslistung
   WHERE v01.phase_id = 0
   GROUP BY 1,2,3,4,5,6,7,8) v04
     
   ON v01.mandant_id = v04.mandant_id
   AND v01.art_id = v04.art_id
   AND  v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id
   AND v01.dat_auslistung = v04.dat_auslistung
   AND v01.phase_id = v04.phase_id
   AND v01.kjwo = v04.kjwo

   
    LEFT JOIN (

     SELECT 
     v02.mandant_id
     ,v02.art_id
     ,v02.wup_id
     ,v02.nb_id
     ,v02.dat_auslistung
     ,v02.menge_endbestand
     ,v02.vk_netto
     ,MAX(v01.phase_id) AS phase_id
     ,MAX(v01.kjwo) AS kjwo
     
     FROM dbp_view.v_as_food_det_1 v01
     
   JOIN dbp_view.v_as_food_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND  v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id
   AND v01.dat_auslistung = v02.dat_auslistung
   WHERE v01.phase_id = phase_id
   GROUP BY 1,2,3,4,5,6,7) v05
     
   ON v01.mandant_id = v05.mandant_id
   AND v01.art_id = v05.art_id
   AND  v01.wup_id = v05.wup_id
   AND v01.nb_id = v05.nb_id
   AND v01.dat_auslistung = v05.dat_auslistung
   AND v01.phase_id = v05.phase_id
   AND v01.kjwo = v05.kjwo

  JOIN dbp_view.v_mandant_wrg_typ_zu_1 v1
  ON v01.mandant_id = v1.mandant_id
  AND v1.wrg_typ_id = 1

  CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v2
  
  JOIN dbp_view.v_kurs_1 v03
  ON CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
  AND v1.wrg_id = v03.von_wrg_id
  AND v03.kurstyp_id = 3
  AND v03.nach_wrg_id ='EUR'

    WHERE v01.phase_id <> 4
    
  QUALIFY ROW_NUMBER() OVER( PARTITION BY v01.art_id, v01.mandant_id, v01.nb_id, v01.wup_id, v01.dat_auslistung, v01.kjwo ORDER BY v01.phase_id DESC) =1;