-- KFL_PRODUCTION_CLONE_SCM.DBP_MSI_VIEW_SCM.MV_TS_WBS_ARTIKEL_VZ_2 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WBS_ARTIKEL_VZ_2(
	MANDANT_ID,
	AUSLIEFERGRUPPE_ID,
	KJWO,
	ANGEBOT_ID,
	AKTION_ID,
	ART_ID,
	WUP_ID_VZ,
	NB_ID_VZ,
	MANDANT_ID_VZ,
	CLEAR_STOCK_ID,
	CLEAR_STOCK_BEZ,
	ESTIMATION_FG,
	MAX_KAPA_FG,
	ADJUSTMENT_FG,
	DAT_LETZTE_NACHVERSORGUNG
) AS
-- 20210927| SPEC0093937 | cbru1709 | Initial view
-- Das nur noch die Artikel_2 angezeigt werden, aus der letzen Beladung 
--2023-07-18, AP0181594, SPEC0207695, dknop, removing aug.estimation_fg from definition of estimation_fg
--2025-04-04, dknop, AP0268913,SPEC0305225, removal of auslieferungsgruppe_id from join to ts_wbs_warengruppe_standard_2, ts_wbs_warengruppe_2
-- Das nur noch die Artikel_2 angezeigt werden, aus der letzen Beladung 
--2025-06-12, column name change to ADJUSTMENT_ID
--2025-10-28, AP0181594, SPEC0207695, dknop, removing aug.adjustment_id from definition of adjustment_id
WITH DAT_Eingrezung AS (
SELECT MANDANT_ID, MAX(DAT_Beladung) AS max_dat_beladung 
FROM DBP_VIEW.v_wbs_werbeaenderungen_2
GROUP BY MANDANT_ID
)

SELECT 
	v00.mandant_id
    ,v00.ausliefergruppe_id
    ,v00.kjwo
    ,v00.offer_id AS angebot_id
    ,v00.aktion_id
    ,v00.art_id
    ,v00.wup_id_vz
    ,v00.nb_id_vz
    ,v00.mandant_id_vz
    --,COALESCE(v00.gp_id,-9) AS gp_id
    --,COALESCE(v01.bezugsweg_id,-9) AS bezugsweg_id
    ,MAX(COALESCE(v01.clear_stock_id,0)) AS clear_stock_id
    ,MAX(COALESCE(v10.clear_stock_bez,'kein')) AS clear_stock_bez
    ,MAX(COALESCE(COALESCE(COALESCE(v01.estimation_fg,wg.estimation_fg),wg_std.estimation_fg)/*,aug.estimation_fg)*/,0)) AS estimation_fg
    ,MAX(COALESCE(v01.max_kapa_fg,0)) AS max_kapa_fg
    ,MAX(COALESCE(COALESCE(COALESCE(v01.adjustment_id,wg.adjustment_id),wg_std.adjustment_id)/*,aug.adjustment_id)*/,0)) AS adjustment_fg
    ,MAX(v01.dat_letzte_nachversorgung) AS dat_letzte_nachversorgung
	 
FROM DBP_VIEW.v_wbs_werbeaenderungen_2 v00
JOIN DAT_Eingrezung v99
ON v00.mandant_id = v99.mandant_id 
AND v00.dat_beladung = v99.max_dat_beladung
LEFT JOIN DBP_VIEW.v_ts_wbs_artikel_vz_2 v01
	ON (v00.mandant_id = v01.mandant_id AND v00.ausliefergruppe_id = v01.ausliefergruppe_id 
		AND v00.kjwo = v01.kjwo AND v00.offer_id = v01.angebot_id AND v00.aktion_id = v01.aktion_id
		AND v00.art_id = v01.art_id AND v00.wup_id_vz = v01.wup_id_vz AND v00.nb_id_vz = v01.nb_id_vz
		AND v00.mandant_id_vz = v01.mandant_id_vz)
LEFT JOIN DBP_VIEW.V_L_CLEAR_STOCK_2 v10
    ON v01.clear_stock_id = v10.clear_stock_id
        AND v01.mandant_id = v10.mandant_id
        
/*LEFT JOIN DBP_VIEW.V_TS_WBS_AUSLIEFERGRUPPE_2 aug                     -- TS auf Ausliefergruppe 
ON v00.MANDANT_ID = aug.MANDANT_ID
AND v00.AUSLIEFERGRUPPE_ID = aug.AUSLIEFERGRUPPE_ID */

JOIN dbp_view.v_art_wg_zu_per_2 wg_zu
ON wg_zu.mandant_id = v00.mandant_id
AND wg_zu.art_id = v00.art_id
AND wg_zu.arthiertyp_id=2
AND wg_zu.dat_bis = '9999-12-31'
LEFT JOIN  DBP_MSI_DATA.TS_WBS_WARENGRUPPE_2 wg                         -- TS auf WG Ebene 
ON wg_zu.MANDANT_ID = wg.MANDANT_ID
    --AND v00.AUSLIEFERGRUPPE_ID = wg.AUSLIEFERUNGSGRUPPE_ID 
    AND wg_zu.WG_ID = wg.WG_ID
    AND v00.kjwo = wg.kjwo
LEFT JOIN  DBP_MSI_DATA.TS_WBS_WARENGRUPPE_STANDARD_2 wg_std                         -- TS auf WG Ebene 
ON wg_zu.MANDANT_ID = wg_std.MANDANT_ID
   -- AND v00.AUSLIEFERGRUPPE_ID = wg_std.AUSLIEFERUNGSGRUPPE_ID 
    AND wg_zu.WG_ID = wg_std.WG_ID

GROUP BY 	
	v00.mandant_id
    ,v00.ausliefergruppe_id
    ,v00.kjwo
    ,v00.offer_id
    ,v00.aktion_id
    ,v00.art_id
    ,v00.wup_id_vz
    ,v00.nb_id_vz
    ,v00.mandant_id_vz
    --,v00.gp_id
    --,v01.bezugsweg_id
    ;