CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_F_VIS_MONAT_UMS_KUNDE_1(
	MANDANT_ID,
	WRG_ID,
	WRG_TYP_ID,
	WUP_ID,
	WE_INTRENO,
	KJMO,
	GJ,
	F_ANZ_KUNDE,
	F_UMS_NETTO,
	AKT_BUCHUNGS_SCHLUSS,
	KJMO_BUCHUNGSSCHLUSS
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS 

SELECT
  vis.mandant_id
, vis.wrg_id
, kurs.wrg_typ_id
, vis.wup_id 
, we.we_intreno
, vis.kjmo
, vis.gj
, vis.f_anz_kunde 
, vis.f_ums_netto
, vis.akt_buchungs_schluss
, vis.kjmo_buchungsschluss
FROM ( 
	SELECT 
	  vis.mandant_id
	, vis.wrg_id
	, wup.aktuell_wup_id       AS wup_id 
	, vis.kjmo
	, vis.gj
	, ker.akt_buchungs_schluss
	, ker.buchungs_schluss_akt AS kjmo_buchungsschluss
	, SUM(vis.anz_kunde)       AS f_anz_kunde
	, SUM(vis.ums_netto)       AS f_ums_netto 
	FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis
	INNER JOIN dbp_view.v_wup_1 wup_1
	ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	INNER JOIN dbp_view.v_l_buchungsstatus_ker_1 ker
	ON ker.kj_ker_mo_id = vis.kjmo
 
	WHERE vis.nb_id = 0 
	AND vis.akt_gj = 0
	AND vis.ums_netto <> 0 AND vis.anz_kunde <> 0 
 
	GROUP BY ALL
 
	 
	UNION ALL SELECT 
	  vis.mandant_id
	, vis.wrg_id
	, wup.aktuell_wup_id AS wup_id 
	, vis.kjmo -100      AS kjmo
	, vis.gj - 1         AS gj
	, ker.akt_buchungs_schluss - 12 AS akt_buchungs_schluss
	, ker.buchungs_schluss_akt      AS  kjmo_buchungsschluss
	, SUM(vis.anz_kunde_kvj)        AS f_anz_kunde
	, SUM(vis.ums_netto_kvj)        AS f_ums_netto 
	FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis
	INNER JOIN dbp_view.v_wup_1 wup_1
	ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	INNER JOIN dbp_view.v_l_buchungsstatus_ker_1 ker
	ON ker.kj_ker_mo_id = vis.kjmo
 
	WHERE vis.nb_id = 0 
	AND vis.akt_gj BETWEEN -2 AND 0
 
	GROUP BY ALL
) vis 
 
INNER JOIN dbp_view.v_immo_wirtschaftseinheit_1 we
ON vis.mandant_id = we.mandant_id AND vis.wup_id = we.wirtschaftseinheit_id
AND we.dat_we_gueltig_bis = '9999-12-31'
 
INNER JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 kurs_1
ON  vis.mandant_id = kurs.mandant_id AND vis.wrg_id = kurs.wrg_id 
AND kurs.kurs_dat_bis = '9999-12-31'
;