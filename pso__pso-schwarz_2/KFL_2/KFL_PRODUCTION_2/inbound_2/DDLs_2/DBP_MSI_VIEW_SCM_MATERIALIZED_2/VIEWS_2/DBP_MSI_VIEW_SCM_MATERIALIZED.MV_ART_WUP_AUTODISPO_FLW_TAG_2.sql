create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_AUTODISPO_FLW_TAG_2(
	MANDANT_ID,
	WUP_ID,
	WUP_ID_FLEISCHWERK,
	NB_ID,
	NB_ID_VZ,
	ART_ID,
	DAT,
	KJWO,
	WE_BEARBEITUNGSZEIT,
	PLANLIEFERZEIT,
	KDIS,
	VERKAUFSLISTUNG_FG,
	SA_AF_FG,
	UDF_PROGNOSE_MENGE_GESTEUERT,
	UDF_PROGNOSE_MENGE_UNGESTEUERT,
	UDF_PROGNOSE_MENGE_GESTEUERT_AF,
	UDF_PROGNOSE_MENGE_GESTEUERT_SA,
	UDF_PROGNOSE_MENGE_UNGESTEUERT_AF,
	UDF_PROGNOSE_MENGE_UNGESTEUERT_SA,
	FUR_PROGNOSE_MENGE_UNGESTEUERT,
	FUR_PROGNOSE_MENGE_GESTEUERT,
	FUR_PROGNOSE_MENGE_MAX,
	MENGE_ABVERKAUF,
	MENGE_ABVERKAUF_AF,
	MENGE_ABVERKAUF_SA,
	ABS_DIFF_FUR_UNGESTEUERT,
	ABS_DIFF_FUR_UNGESTEUERT_AF,
	ABS_DIFF_FUR_UNGESTEUERT_SA,
	ABS_DIFF_FUR_GESTEUERT,
	ABS_DIFF_FUR_GESTEUERT_AF,
	ABS_DIFF_FUR_GESTEUERT_SA,
	RET_BESTAND,
	FUR_BESTAND,
	MENGE_WE_OFFEN,
	MENGE_BV,
	MENGE_OFC,
	NULLBESTAND_FG,
	MENGE_TOTALABSCHRIFTEN,
	MENGE_PREISABSCHRIFTEN,
	KOLLIFAKTOR,
	EGALISIERUNGSFAKTOR,
	MENGE_EINH_ID,
	SERVICELEVEL,
	OPTIK,
	MENGE_WE,
	TEMPERATUR_MIN,
	TEMPERATUR_MAX,
	DAUER_SONNENSCHEIN_PERC,
	REGENRISIKO_PERC,
	NULLBESTAND_EXC_FG
) as










SELECT
 v01.mandant_id


, v05.aktuell_wup_id  wup_id

,v01.wup_id AS wup_id_fleischwerk
,v01.nb_id_kunde AS nb_id

,v01.nb_id_lieferant AS nb_id_vz
,v01.art_id
,v01.dat
,t01.kjwo
,COALESCE(v01.we_bearbeitungszeit,-1) AS we_bearbeitungszeit
,COALESCE(v01.planlieferzeit,-1) AS planlieferzeit
,v01.kdis
,v01.verkaufslistung_fg
,v01.sa_af_fg

,udf_prognose_menge_gesteuert
,udf_prognose_menge_ungesteuert
,CASE WHEN v01.sa_af_fg=0 THEN v01.udf_prognose_menge_gesteuert ELSE 0 END AS udf_prognose_menge_gesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN v01.udf_prognose_menge_gesteuert ELSE 0 END AS udf_prognose_menge_gesteuert_sa
,CASE WHEN v01.sa_af_fg=0 THEN v01.udf_prognose_menge_ungesteuert ELSE 0 END AS udf_prognose_menge_ungesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN v01.udf_prognose_menge_ungesteuert ELSE 0 END AS udf_prognose_menge_ungesteuert_sa
,v01.fur_prognose_menge_ungesteuert
,v01.fur_prognose_menge_gesteuert 
,v01.fur_prognose_menge_max

,v01.menge_abverkauf
,CASE  WHEN v01.sa_af_fg=0 THEN v01.menge_abverkauf ELSE 0 END AS menge_abverkauf_af
,CASE  WHEN v01.sa_af_fg=1 THEN v01.menge_abverkauf ELSE 0 END AS menge_abverkauf_sa


,ABS(v01.menge_abverkauf - v01.fur_prognose_menge_ungesteuert) AS abs_diff_fur_ungesteuert
,CASE WHEN v01.sa_af_fg=0 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_ungesteuert) ELSE NULL END AS abs_diff_fur_ungesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_ungesteuert) ELSE NULL END AS abs_diff_fur_ungesteuert_sa
,ABS(v01.menge_abverkauf - v01.fur_prognose_menge_gesteuert) AS abs_diff_fur_gesteuert
,CASE WHEN v01.sa_af_fg=0 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_gesteuert) ELSE NULL END AS abs_diff_fur_gesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_gesteuert) ELSE NULL END AS abs_diff_fur_gesteuert_sa

,v01.ret_bestand
,v01.fur_bestand
,v01.menge_we_offen
,v01.menge_bv
,v01.menge_ofc
,COALESCE(v01.nullbestand_fg,-1) AS nullbestand_fg
,v01.menge_totalabschriften
,v01.menge_preisabschriften
,v01.kollifaktor
,v01.egalisierungsfaktor
,v01.menge_einh_id
,v01.servicelevel
,v01.optik
,v01.menge_we
,v02.temperatur_min
,v02.temperatur_max
,v02.dauer_sonnenschein AS dauer_sonnenschein_perc
,v03.regenrisiko_perc
,v01.nullbestand_exc_fg





FROM DBP_VIEW.v_art_wup_autodispo_flw_tag_2 v01

JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id
   AND v05.wup_id = v01.kunde_id
   AND v05.nb_id = 0

JOIN DBP_VIEW.v_tag_2 t01 
  ON v01.dat = t01.dat

LEFT JOIN DBP_VIEW.v_wup_wetter_tag_2 v02
  ON v01.mandant_id  = v02.mandant_id 
 AND v01.kunde_id    = v02.wup_id 
 AND v01.nb_id_kunde = v02.nb_id 
 AND v01.dat         = v02.dat

LEFT JOIN (SELECT mandant_id
                 ,wup_id
                 ,dat
                 ,AVG(CAST(regenrisiko AS DEC(5,2))) AS regenrisiko_perc
           FROM DBP_VIEW.v_wup_wetter_tag_stunde_2  
           WHERE zeit_stunde IN (12,18)
           GROUP BY mandant_id
                   ,wup_id
				   ,dat
          ) v03
  ON v01.mandant_id = v03.mandant_id 
 AND v01.kunde_id   = v03.wup_id 
 AND v01.dat        = v03.dat

JOIN (SELECT MAX(dat_bis) AS max_dat FROM DBP_VIEW.v_aktion_2 WHERE mandant_id= 1 AND aktionsart_id = 'ZFL') zfl
ON v01.mandant_id <> 1 
OR (v01.mandant_id = 1 AND v01.wup_id NOT BETWEEN 6912 AND 6922) 
OR v01.dat <= zfl.max_dat;