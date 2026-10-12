CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_scm.MV_DT_ART_WUP_AUTODISPO_FLW_TAG(
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
	NULLBESTAND_EXC_FG,
	MENGE_WE_GEPLANT,
	DISPLAY_ART_ID,
	KOMPONENTENMENGE
) 
TARGET_LAG = '15 minutes' refresh_mode = AUTO initialize = ON_CREATE
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG
AS
-- 2020-09-03, AP0068964, nwag2310, added KJWO from TAG for performance
-- 2020-09-03, AP0068964, nwag2310, added UDF Prognose gesteuertungesteuert as replacement vor tagvortag
-- 2020-09-23, AP0068964, nwag2310, removed old columns - tagvortag
-- 2020-12-02, AP0068964, nwag2310, added EXC209
-- 2021-02-01, AP0068964, nwag2310, added filter on max dat Aktion  wetter from view layer
-- 2021-03-16, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion, srom0404, added ArtikelCluster + MarktCluster
-- 2021-04-15, AP0068964, srom0404, sa_af_fg unique naming conventions
-- 2023-02-07, dknop, updating 'where' part
--2023-02-07, dknop, updating 'where' part
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2025-07-11, AP0259077, nwag2310, turn into DT
--2025-08-04, AP0259077, SPEC0324636, dknop, add MENGE_WE_GEPLANT,DISPLAY_ART_ID,KOMPONENTENMENGE
SELECT
 v01.mandant_id
--,v01.kunde_id AS wup_id
--, CASE WHEN TRY_CAST(v01.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id
, v05.aktuell_wup_id  wup_id
--v01.wup_id AS fleischwerk_wup_id
,v01.wup_id AS wup_id_fleischwerk
,v01.nb_id_kunde AS nb_id
--v01.nb_id_lieferant AS vz_nb_id
,v01.nb_id_lieferant AS nb_id_vz
,v01.art_id
,v01.dat
,t01.kjwo
,COALESCE(v01.we_bearbeitungszeit,-1) AS we_bearbeitungszeit
,COALESCE(v01.planlieferzeit,-1) AS planlieferzeit
,v01.kdis
,v01.verkaufslistung_fg
,v01.sa_af_fg
--,CASE  WHEN v01.sa_af_fg=0 THEN 'AF' WHEN v01.sa_af_fg=1 THEN 'SA' ELSE '--' END AS sa_af_fg
,udf_prognose_menge_gesteuert
,udf_prognose_menge_ungesteuert
,CASE WHEN v01.sa_af_fg=0 THEN v01.udf_prognose_menge_gesteuert ELSE 0 END AS udf_prognose_menge_gesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN v01.udf_prognose_menge_gesteuert ELSE 0 END AS udf_prognose_menge_gesteuert_sa
,CASE WHEN v01.sa_af_fg=0 THEN v01.udf_prognose_menge_ungesteuert ELSE 0 END AS udf_prognose_menge_ungesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN v01.udf_prognose_menge_ungesteuert ELSE 0 END AS udf_prognose_menge_ungesteuert_sa
,v01.fur_prognose_menge_ungesteuert
,v01.fur_prognose_menge_gesteuert 
,v01.fur_prognose_menge_max
--Abverkauf subject to change
,v01.menge_abverkauf
,CASE  WHEN v01.sa_af_fg=0 THEN v01.menge_abverkauf ELSE 0 END AS menge_abverkauf_af
,CASE  WHEN v01.sa_af_fg=1 THEN v01.menge_abverkauf ELSE 0 END AS menge_abverkauf_sa
--Abverkauf
--Absolute Difference (for wMape calculation)
,ABS(v01.menge_abverkauf - v01.fur_prognose_menge_ungesteuert) AS abs_diff_fur_ungesteuert
,CASE WHEN v01.sa_af_fg=0 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_ungesteuert) ELSE NULL END AS abs_diff_fur_ungesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_ungesteuert) ELSE NULL END AS abs_diff_fur_ungesteuert_sa
,ABS(v01.menge_abverkauf - v01.fur_prognose_menge_gesteuert) AS abs_diff_fur_gesteuert
,CASE WHEN v01.sa_af_fg=0 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_gesteuert) ELSE NULL END AS abs_diff_fur_gesteuert_af
,CASE WHEN v01.sa_af_fg=1 THEN ABS(v01.menge_abverkauf - v01.fur_prognose_menge_gesteuert) ELSE NULL END AS abs_diff_fur_gesteuert_sa
--Absolute Diff.
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
,v01.nullbestand_exc_fg,
-- nicht zugeordnete Märkte oder Artikel, werden dem Cluster -99 zugeordent
-- Damit im Pflegebericht 01.08.02 Autodispo Ultra-Frische Steuerung Detail alles angezeigt wird, den Cluster hier mit LEFT JOIN ermitteln
--,COALESCE(v04.art_cluster_id,-99) AS art_cluster_id
--,COALESCE(v05.wup_cluster_id,-99) AS wup_cluster_id
menge_we_geplant,
display_art_id,
komponentenmenge

FROM DBP_VIEW.v_art_wup_autodispo_flw_tag v01

JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id
   AND v05.wup_id = v01.kunde_id
   AND v05.nb_id = v01.nb_id_kunde

JOIN DBP_VIEW.v_tag t01 
  ON v01.dat = t01.dat
  AND t01.akt_kj >= -2

LEFT JOIN DBP_VIEW.v_wup_wetter_tag v02
  ON v01.mandant_id  = v02.mandant_id 
 AND v01.kunde_id    = v02.wup_id 
 AND v01.nb_id_kunde = v02.nb_id 
 AND v01.dat         = v02.dat

LEFT JOIN (SELECT mandant_id
                 ,wup_id
                 ,dat
                 ,AVG(CAST(regenrisiko AS DEC(5,2))) AS regenrisiko_perc
           FROM DBP_VIEW.v_wup_wetter_tag_stunde  
           WHERE zeit_stunde IN (12,18)
           GROUP BY mandant_id
                   ,wup_id
				   ,dat
          ) v03
  ON v01.mandant_id = v03.mandant_id 
 AND v01.kunde_id   = v03.wup_id 
 AND v01.dat        = v03.dat

JOIN (SELECT MAX(dat_bis) AS max_dat FROM DBP_VIEW.v_aktion WHERE mandant_id= 1 AND aktionsart_id = 'ZFL') zfl
ON v01.mandant_id <> 1 
OR (v01.mandant_id = 1 AND v01.wup_id NOT BETWEEN 6912 AND 6922) 
OR v01.dat <= zfl.max_dat
;