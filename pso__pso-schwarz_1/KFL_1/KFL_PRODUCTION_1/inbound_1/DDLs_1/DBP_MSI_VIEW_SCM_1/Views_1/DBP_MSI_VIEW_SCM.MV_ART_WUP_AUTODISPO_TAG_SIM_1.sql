
CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_WUP_AUTODISPO_TAG_SIM_1(
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
) AS 
-- 2020-09-03, AP0068964, nwag2310, Ersterstellung, simulation has the forecast value with all DIFs applied --> important part is the handling of concurrent DIF types (order)
-- 2020-09-08, AP0068964, nwag2310, changed left join so sim-value will have original value if no DIF is maintained --> PERFORMANCE ISSUE ! derived metric in report?!!
-- 2020-09-15, AP0068964, nwag2310, added kjwo from TAG_1 for performance; DIF Status_1 now 0+1 (2 would be transferred)
-- 2020-09-15, AP0068964, nwag2310, if amount is < 0 in the end set to 0.
-- 2020-09-23, AP0068964, nwag2310, switch from FUR + UDF prognose gesteuert
-- 2020-11-04, AP0068964, nwag2310, filter on dif_status not needed anymore
-- 2021-04-15, AP0068964, srom0404, added additional attribute forms to avoid additional JOIN, sa_af_fg unique naming conventions
--2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2025-07-11, AP0259077, nwag2310, minor perf. impr
--2025-08-04, AP0259077, SPEC0324636, dknop, add MENGE_WE_GEPLANT,DISPLAY_ART_ID,KOMPONENTENMENGE
SELECT
 f.mandant_id
--,f.kunde_id AS wup_id
--,CASE WHEN TRY_CAST(f.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id
,v05.aktuell_wup_id wup_id
-- ,f.wup_id AS fleischwerk_wup_id
,f.wup_id AS wup_id_fleischwerk
,f.nb_id_kunde AS nb_id
-- ,f.nb_id_lieferant AS vz_nb_id
,f.nb_id_lieferant AS nb_id_vz
,f.art_id
,f.dat
,t.kjwo
,f.menge_einh_id
-- these columns are for debugging / future + internal use:
,dif.anz_dif_mult
,dif.anz_dif_add
,dif.anz_dif_abs
,f.udf_prognose_menge_gesteuert
,f.udf_prognose_menge_gesteuert * dif.dif_mult AS prog_mit_dif_mult
,f.udf_prognose_menge_gesteuert + (dif.dif_add*f.egalisierungsfaktor) AS prog_mit_dif_add
,(dif.dif_abs*f.egalisierungsfaktor) AS prog_mit_dif_abs

-- added and activated on attributes to avoid additional JOIN to mv_art_wup_autodispo_flw_tag_1 in MSTR Report SQL
-- e.g. at Report [SCM_Dataset 99.21 Autodispo Ultra-Frische IST Detail]
,f.verkaufslistung_fg
,Coalesce(f.we_bearbeitungszeit,-1) AS we_bearbeitungszeit
,Coalesce(f.planlieferzeit,-1) AS planlieferzeit
,Coalesce(f.nullbestand_fg,-1) AS nullbestand_fg
,f.sa_af_fg
,f.kdis

-- this one goes to MSTR:
,CASE  -- abs. DIF overrules everything
            WHEN dif.dif_abs IS NOT NULL THEN prog_mit_dif_abs 
            -- if mult. AND add. are specified: 1. multiply, 2. add
            WHEN (dif.dif_mult IS NOT NULL AND dif.dif_add IS NOT NULL) THEN prog_mit_dif_mult + (dif.dif_add*f.egalisierungsfaktor) 
            -- last two possibilities: only mult. or add. (trivial)
            WHEN dif.dif_mult IS NOT NULL THEN prog_mit_dif_mult 
            WHEN dif.dif_add IS NOT NULL THEN prog_mit_dif_add 
            ELSE f.udf_prognose_menge_gesteuert END AS fur_prognose_menge_sim_tmp
,CASE WHEN fur_prognose_menge_sim_tmp < 0 THEN 0.00 ELSE fur_prognose_menge_sim_tmp END AS fur_prognose_menge_sim 
,f.menge_we_geplant
,f.display_art_id
,f.komponentenmenge
FROM DBP_VIEW.v_art_wup_autodispo_flw_tag_1  f
		-- big exception to use other MV in this MV because encaspulation resolve-logic makes more sense!
JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = f.mandant_id
   AND v05.wup_id = f.kunde_id
   AND  v05.nb_id = f.nb_id_kunde

JOIN DBP_VIEW.v_tag_1 t 
  ON f.dat = t.dat

LEFT JOIN dbp_msi_view_scm.mv_art_wup_autodispo_tag_dif_bme_1  dif 
  ON dif.mandant_id = f.mandant_id
 AND dif.kunde_id   = f.kunde_id
 AND dif.art_id     = f.art_id
 AND dif.dat        = f.dat
;
