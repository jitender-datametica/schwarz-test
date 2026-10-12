create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_AUTODISPO_TAG_SIM(
	MANDANT_ID,
	WUP_ID,
	WUP_ID_FLEISCHWERK,
	NB_ID,
	NB_ID_VZ,
	ART_ID,
	DAT,
	KJWO,
	MENGE_EINH_ID,
	ANZ_DIF_MULT,
	ANZ_DIF_ADD,
	ANZ_DIF_ABS,
	UDF_PROGNOSE_MENGE_GESTEUERT,
	PROG_MIT_DIF_MULT,
	PROG_MIT_DIF_ADD,
	PROG_MIT_DIF_ABS,
	VERKAUFSLISTUNG_FG,
	WE_BEARBEITUNGSZEIT,
	PLANLIEFERZEIT,
	NULLBESTAND_FG,
	SA_AF_FG,
	KDIS,
	FUR_PROGNOSE_MENGE_SIM_TMP,
	FUR_PROGNOSE_MENGE_SIM,
	MENGE_WE_GEPLANT,
	DISPLAY_ART_ID,
	KOMPONENTENMENGE
) as 










SELECT
 f.mandant_id


,v05.aktuell_wup_id wup_id

,f.wup_id AS wup_id_fleischwerk
,f.nb_id_kunde AS nb_id

,f.nb_id_lieferant AS nb_id_vz
,f.art_id
,f.dat
,t.kjwo
,f.menge_einh_id

,dif.anz_dif_mult
,dif.anz_dif_add
,dif.anz_dif_abs
,f.udf_prognose_menge_gesteuert
,f.udf_prognose_menge_gesteuert * dif.dif_mult AS prog_mit_dif_mult
,f.udf_prognose_menge_gesteuert + (dif.dif_add*f.egalisierungsfaktor) AS prog_mit_dif_add
,(dif.dif_abs*f.egalisierungsfaktor) AS prog_mit_dif_abs



,f.verkaufslistung_fg
,Coalesce(f.we_bearbeitungszeit,-1) AS we_bearbeitungszeit
,Coalesce(f.planlieferzeit,-1) AS planlieferzeit
,Coalesce(f.nullbestand_fg,-1) AS nullbestand_fg
,f.sa_af_fg
,f.kdis


,CASE  
            WHEN dif.dif_abs IS NOT NULL THEN prog_mit_dif_abs 
            
            WHEN (dif.dif_mult IS NOT NULL AND dif.dif_add IS NOT NULL) THEN prog_mit_dif_mult + (dif.dif_add*f.egalisierungsfaktor) 
            
            WHEN dif.dif_mult IS NOT NULL THEN prog_mit_dif_mult 
            WHEN dif.dif_add IS NOT NULL THEN prog_mit_dif_add 
            ELSE f.udf_prognose_menge_gesteuert END AS fur_prognose_menge_sim_tmp
,CASE WHEN fur_prognose_menge_sim_tmp < 0 THEN 0.00 ELSE fur_prognose_menge_sim_tmp END AS fur_prognose_menge_sim 
,f.menge_we_geplant
,f.display_art_id
,f.komponentenmenge
FROM DBP_VIEW.v_art_wup_autodispo_flw_tag  f
		
JOIN dbp_view.v_wup v05
   ON v05.mandant_id = f.mandant_id
   AND v05.wup_id = f.kunde_id
   AND  v05.nb_id = f.nb_id_kunde

JOIN DBP_VIEW.v_tag t 
  ON f.dat = t.dat

LEFT JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.mv_art_wup_autodispo_tag_dif_bme  dif 
  ON dif.mandant_id = f.mandant_id
 AND dif.kunde_id   = f.kunde_id
 AND dif.art_id     = f.art_id
 AND dif.dat        = f.dat;