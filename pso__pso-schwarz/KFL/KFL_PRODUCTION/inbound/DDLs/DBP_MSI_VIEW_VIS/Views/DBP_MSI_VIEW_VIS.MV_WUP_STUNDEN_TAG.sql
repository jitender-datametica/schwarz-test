create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WUP_STUNDEN_TAG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	DAT,
	WTAG_ID,
	AKT_TAG,
	AKT_WO,
	AKT_WO_KOMPLETT,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_GJ,
	ANZ_OFFEN,
	UMS_NETTO,
	UMS_NETTO_WVJ,
	UMS_NETTO_PLAN,
	UMS_NETTO_PLAN_MAN,
	STUNDEN_SONSTIGE,
	STUNDEN_PLAN,
	STUNDEN_SONSTIGE_PLAN,
	STUNDEN_MARKT,
	STUNDEN_PLAN_PEP,
	STUNDEN_CO_IST,
	STUNDEN_CO1_IKS,
	STUNDEN_CO2_EA,
	STUNDEN_CO3_ANUE,
	STUNDEN_CO4_REINIGUNG,
	STUNDEN_CO5_SONSTIGE,
	STUNDEN_CO_PLAN,
	STUNDEN_JAHRESPLAN_SSM,
	HOCH_FG,
	PLAN_FG,
	PLAN_FG1,
	PLAN_FG2,
	BASIS_STUNDEN_IST_CO,
	BASIS_STUNDEN_IST_CO2,
	BASIS_STUNDEN_PLAN_CO,
	BASIS_STUNDEN_IST,
	BASIS_STUNDEN_PLAN_HL,
	BASIS_STUNDEN_PLAN_PEP,
	NETTO_STUNDEN_IST,
	NETTO_STUNDEN_IST2,
	NETTO_STUNDEN_PLAN_HL,
	NETTO_STUNDEN_PLAN_PEP,
	NETTO_STUNDEN_PLAN,
	NETTO_STUNDEN_HOCH,
	UMSATZ_NETTO_IST,
	UMSATZ_NETTO_PLAN_KER,
	UMSATZ_NETTO_PLAN_HL,
	UMSATZ_NETTO_PLAN,
	UMSATZ_NETTO_HOCH,
	STUNDEN_PLAN_MELDESCHLUSS_PLUS1,
	STUNDEN_PLAN_MELDESCHLUSS_PLUS2,
	STUNDEN_SONSTIGE_PLAN_PLUS1,
	STUNDEN_SONSTIGE_PLAN_PLUS2,
	STUNDEN_CO_PLAN_PLUS1,
	STUNDEN_CO_PLAN_PLUS2,
	UMS_NETTO_PLAN_MAN_MELDESCHLUSS_PLUS1,
	UMS_NETTO_PLAN_MAN_MELDESCHLUSS_PLUS2,
	UMSATZ_NETTO_PLAN_PLUS2,
	ABW,
	FILIALEBENE_ID,
	STUNDEN_VERSETZUNG,
	UMS_NETTO_PLAN_MAN_MELDESCHLUSS,
	STUNDEN_PLAN_MELDESCHLUSS
) as
























WITH 
zeit AS (

	SELECT dat
		, wtag_id 
		, akt_tag 
		, akt_wo 
		, akt_wo_komplett 
		, akt_mo 
		, akt_mo_komplett 
		, akt_gj
	FROM dbp_data.tag
	WHERE akt_gj BETWEEN -3 AND 1 
	), 
basis_vis AS (

	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wrg_id
		, vis.wup_id 
		, vis.dat
		, zeit.wtag_id
		, zeit.akt_tag
		, zeit.akt_wo
		, zeit.akt_wo_komplett
		, zeit.akt_mo
		, zeit.akt_mo_komplett
		, zeit.akt_gj
		, SUM(vis.anz_offen)      AS offen
		, SUM(vis.ums_netto)      AS ums_ist
		, SUM(vis.ums_netto_plan) AS ums_plan
		, SUM(vis.ums_netto_wvj)  AS ums_wvj
	FROM dbp_msi_view_vis.mv_vis_tag_fakt_wup vis
	INNER JOIN zeit
		ON zeit.dat = vis.dat
	WHERE vis.nb_id IN (-1, 0)
	GROUP BY ALL
	), 
basis_wst AS (

	SELECT wst.mandant_id
		, krs.nach_wrg_id    AS wrg_id
		, wup.aktuell_wup_id AS wup_id 
		, wst.dat
		, SUM(wst.stunden_markt)                   AS std_ist
		, SUM(wst.stunden_sonstige)                AS std_ist_sonst
		, SUM(wst.stunden_plan)                    AS std_plan
		, SUM(wst.stunden_plan_pep)                AS std_plan_pep
		, SUM(wst.stunden_sonstige_plan)           AS std_plan_sonst
		, SUM(wst.stunden_plan_meldeschluss_plus1) AS std_plan_plus1
		, SUM(wst.stunden_plan_meldeschluss_plus2) AS std_plan_plus2
		, SUM(wst.stunden_sonstige_plan_plus1)     AS std_plan_sonst_plus1
		, SUM(wst.stunden_sonstige_plan_plus2)     AS std_plan_sonst_plus2
		, SUM(wst.stunden_co_ist)        AS co_ist
		, SUM(wst.stunden_co1_iks)       AS co1
		, SUM(wst.stunden_co2_ea)        AS co2
		, SUM(wst.stunden_co3_anue)      AS co3
		, SUM(wst.stunden_co4_reinigung) AS co4
		, SUM(wst.stunden_co5_sonstige)  AS co5
		, SUM(wst.stunden_co_plan)       AS co_plan
		, SUM(wst.stunden_co_plan_plus1) AS co_plan_plus1
		, SUM(wst.stunden_co_plan_plus2) AS co_plan_plus2
		, SUM(wst.ums_netto_plan_man                    * krs.umrechnungskurs) AS ums_plan_man
		, SUM(wst.ums_netto_plan_man_meldeschluss_plus1 * krs.umrechnungskurs) AS ums_plan_man_plus1
		, SUM(wst.ums_netto_plan_man_meldeschluss_plus2 * krs.umrechnungskurs) AS ums_plan_man_plus2
		, SUM(wst.stunden_plan_ssm) AS std_plan_ssm
		
		
	FROM dbp_view.v_wup_stunden_tag wst
	INNER JOIN dbp_view.v_wup wup
		ON wup.mandant_id = wst.mandant_id AND wup.wup_id = wst.wup_id
	 INNER JOIN zeit
		ON zeit.dat = wst.dat
	INNER JOIN (
		SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
		FROM dbp_data.kurs krs1
		WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31'
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
		UNION ALL
		SELECT krs2.von_wrg_id, krs2.von_wrg_id AS nach_wrg_id, 1.00000 AS umrechnungskurs
		FROM dbp_data.kurs krs2
		WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' 
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')
	) krs
	ON krs.von_wrg_id = wst.wrg_id 
	WHERE wst.nb_id IN (-1, 0)
	GROUP BY ALL
)

SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.dat
	, vis.wtag_id
	, vis.akt_tag
	, vis.akt_wo
	, vis.akt_wo_komplett
	, vis.akt_mo
	, vis.akt_mo_komplett
	, vis.akt_gj

	, vis.offen    AS anz_offen
	, vis.ums_ist  AS ums_netto
	, vis.ums_wvj  AS ums_netto_wvj
	, vis.ums_plan AS ums_netto_plan 

	, wst.ums_plan_man   AS ums_netto_plan_man    
	, wst.std_ist_sonst  AS stunden_sonstige      
	, wst.std_plan       AS stunden_plan          
	, wst.std_plan_sonst AS stunden_sonstige_plan 

	, wst.std_ist      AS stunden_markt         
	, wst.std_plan_pep AS stunden_plan_pep      

	, wst.co_ist		AS stunden_co_ist        
	, wst.co1			AS stunden_co1_iks       
	, wst.co2			AS stunden_co2_ea        
	, wst.co3			AS stunden_co3_anue      
	, wst.co4			AS stunden_co4_reinigung 
	, wst.co5			AS stunden_co5_sonstige  
	, wst.co_plan		AS stunden_co_plan       
	, wst.std_plan_ssm	AS stunden_jahresplan_ssm		

	, IFF(vis.akt_tag < 1, 1, 0) AS hoch_fg  
	, CASE vis.mandant_id 
		WHEN 1 THEN IFF(vis.akt_wo_komplett < 3, 1, 0) 
		WHEN 6 THEN IFF(vis.akt_wo_komplett < 3, 1, 0) 
		ELSE 1                                         
	  END AS plan_fg
	, CASE vis.mandant_id 
		WHEN 1 THEN IFF(vis.akt_wo_komplett < 3, 1, 0) 
		WHEN 6 THEN IFF(vis.akt_wo_komplett < 3, 1, 0) 
		ELSE        IFF(vis.akt_mo_komplett < 3, 1, 0) 
	  END AS plan_fg1
	, CASE vis.mandant_id 
		WHEN 1 THEN IFF(vis.akt_wo_komplett < 3, 1, 0) 
		WHEN 6 THEN IFF(vis.akt_wo_komplett < 3, 1, 0) 
		ELSE        IFF(vis.akt_mo_komplett < 2, 1, 0) 
	  END AS plan_fg2

	, ZEROIFNULL(co_ist) + co1 + co2 + co3 + co4 + co5  AS basis_stunden_ist_co
	, basis_stunden_ist_co + ((co4 + co5) * hoch_fg)    AS basis_stunden_ist_co2 
	, ZEROIFNULL(co_plan)  + co4 + co5                  AS basis_stunden_plan_co
	, ZEROIFNULL(std_ist)  + ZEROIFNULL(std_ist_sonst)  AS basis_stunden_ist
	, ZEROIFNULL(std_plan) + ZEROIFNULL(std_plan_sonst) AS basis_stunden_plan_hl
	, stunden_plan_pep     + ZEROIFNULL(std_plan_sonst) AS basis_stunden_plan_pep

	, basis_stunden_ist      + basis_stunden_ist_co                    AS netto_stunden_ist      
	, (basis_stunden_ist     + basis_stunden_ist_co) * hoch_fg         AS netto_stunden_ist2     
	, basis_stunden_plan_hl  + basis_stunden_plan_co                   AS netto_stunden_plan_hl  
	, basis_stunden_plan_pep + basis_stunden_plan_co                   AS netto_stunden_plan_pep 
	, IFF(plan_fg = 1, netto_stunden_plan_pep, netto_stunden_plan_hl)  AS netto_stunden_plan     
	, IFF(hoch_fg = 1, netto_stunden_ist, netto_stunden_plan)          AS netto_stunden_hoch     

	, ums_netto                                                        AS umsatz_netto_ist       
	, ums_netto_plan                                                   AS umsatz_netto_plan_ker  
	, ums_netto_plan_man                                               AS umsatz_netto_plan_hl   
	, IFF(ums_netto_plan_man <> 0, ums_netto_plan_man, ums_netto_plan) AS umsatz_netto_plan      
	, IFF(hoch_fg = 1, umsatz_netto_ist , umsatz_netto_plan)           AS umsatz_netto_hoch      

 
	, wst.std_plan_plus1       AS stunden_plan_meldeschluss_plus1
	, wst.std_plan_plus2       AS stunden_plan_meldeschluss_plus2
	, wst.std_plan_sonst_plus1 AS stunden_sonstige_plan_plus1
	, wst.std_plan_sonst_plus2 AS stunden_sonstige_plan_plus2
	, wst.co_plan_plus1        AS stunden_co_plan_plus1
	, wst.co_plan_plus2        AS stunden_co_plan_plus2
	, wst.ums_plan_man_plus1   AS ums_netto_plan_man_meldeschluss_plus1
	, wst.ums_plan_man_plus2   AS ums_netto_plan_man_meldeschluss_plus2
	, IFF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, ums_netto_plan) AS umsatz_netto_plan_plus2  
	, ((NULLIFZERO(umsatz_netto_ist) - umsatz_netto_plan_plus2) / NULLIFZERO(umsatz_netto_plan_plus2)) * 100.00 AS abw 
	, CASE
		WHEN abw <  -20                   THEN 1
		WHEN abw >= -20   AND abw < -10   THEN 2
		WHEN abw >= -10   AND abw <  -5   THEN 3
		WHEN abw >=  -5   AND abw <  -2.5 THEN 4
		WHEN abw >=  -2.5 AND abw <  -1   THEN 5
		WHEN abw >=  -1   AND abw <=  1   THEN 6
		WHEN abw >    1   AND abw <=  2.5 THEN 7
		WHEN abw >    2.5 AND abw <=  5   THEN 8
		WHEN abw >    5   AND abw <= 10   THEN 9
		WHEN abw >   10   AND abw <= 20   THEN 10
		WHEN abw >   20                   THEN 11
		ELSE -1 END AS filialebene_id

	, NULL AS stunden_versetzung
	, NULL AS ums_netto_plan_man_meldeschluss 
	, NULL AS stunden_plan_meldeschluss 

	
FROM basis_vis vis
LEFT JOIN basis_wst wst
	ON wst.mandant_id = vis.mandant_id 
		AND wst.wup_id = vis.wup_id
		AND wst.wrg_id = vis.wrg_id 
		AND wst.dat = vis.dat
;
