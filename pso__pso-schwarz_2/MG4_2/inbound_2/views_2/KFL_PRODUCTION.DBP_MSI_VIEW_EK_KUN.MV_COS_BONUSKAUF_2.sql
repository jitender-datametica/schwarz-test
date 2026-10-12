create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSKAUF_2(
	MANDANT_ID,
	BONUSKAUF_ID,
	BONUSKAUF_NAME,
	BONUSKAUF_TYP,
	BONUSKAUF_KATEGORIE_BEZ,
	GAMIFICATION_FG,
	WG_ID,
	DAT_VON,
	DAT_BIS,
	BONUSKAUF_BEZ,
	MAX_EINLOESUNG,
	AKTIV_LOYALTY_GESAMT_FG,
	VORAKTIVIERT_FG,
	DAT_VON_BEDINGUNG,
	DAT_BIS_BEDINGUNG,
	KAUF_MIT_PUNKTE_FG,
	KONDITIONSART_ID,
	BONUSKAUF_PROMOTIONSTYP,
	GESCHAEFTSVORFALL_ID,
	VK_BRUTTO,
	VK_AKTION_BRUTTO_LOYALTY,
	BETRAG_PROMO_PROZENT,
	VK_AKTION_BRUTTO,
	BONUSKAUF_PARTNER_FG,
	RECO_FG,
	BONUSKAUF_ANBIETER_NAME,
	BONUSKAUF_CODE_GENERIERUNG_TYP_ID,
	BONUSKAUF_CODE_TYP_ID,
	BONUSKAUF_VORTEILSREGELN_TXT,
	BONUSKAUF_KONDITIONEN_TXT,
	DATZEIT_BIS_EXTERN_EINLOESUNG,
	DATZEIT_VON_EXTERN_EINLOESUNG
) as
SELECT

 v01.mandant_id
,v01.bonuskauf_id
,v01.bonuskauf_name
,v01.bonuskauf_typ
,v01.bonuskauf_kategorie_bez
,v01.gamification_fg

,v01.wg_id
,TO_DATE (v01.dat_von)
,TO_DATE (v01.dat_bis)
,v01.bonuskauf_bez
,v01.max_einloesung
,v01.aktiv_loyalty_gesamt_fg
,v01.voraktiviert_fg
,TO_DATE (v01.dat_von_bedingung)
,TO_DATE (v01.dat_bis_bedingung)
,v01.kauf_mit_punkte_fg
,v01.konditionsart_id
,v01.bonuskauf_promotionstyp
,v01.geschaeftsvorfall_id

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.vk_brutto AS NUMBER(38,5)) * v300.umrechnungskurs
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.vk_brutto AS NUMBER(38,5)) * v400.umrechnungskurs
      ELSE CAST(v01.vk_brutto AS NUMBER(38,5)) END vk_brutto

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.vk_aktion_brutto_loyalty AS NUMBER(38,5)) * v300.umrechnungskurs
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.vk_aktion_brutto_loyalty AS NUMBER(38,5)) * v400.umrechnungskurs
      ELSE CAST(v01.vk_aktion_brutto_loyalty AS NUMBER(38,5)) END vk_aktion_brutto_loyalty

,v01.betrag_promo_prozent
,v01.vk_aktion_brutto
,v01.bonuskauf_partner_fg
,CASE WHEN v01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM') THEN 1 ELSE 0 END reco_fg
,v01.bonuskauf_anbieter_name
,v01.bonuskauf_code_generierung_typ_id
,v01.bonuskauf_code_typ_id






,v01.bonuskauf_vorteilsregeln_txt
,v01.bonuskauf_konditionen_txt
,TO_DATE (v01.datzeit_bis_extern_einloesung)
,TO_DATE (v01.datzeit_von_extern_einloesung)

FROM DBP_VIEW.V_COS_BONUSKAUF_2 v01

CROSS JOIN DBP_MSI.AKT_MSI_USER_WRG_TYP_ZU_2 v02 






   
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   
   JOIN dbp_view.v_kurs_2 v400
   ON CURRENT_DATE BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR';