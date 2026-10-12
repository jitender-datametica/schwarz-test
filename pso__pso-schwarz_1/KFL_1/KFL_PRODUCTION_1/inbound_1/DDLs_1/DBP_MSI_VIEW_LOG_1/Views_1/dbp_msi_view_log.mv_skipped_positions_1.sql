CREATE OR REPLACE VIEW dbp_msi_view_log.mv_skipped_positions_1
(
MANDANT_ID,
	LAGERAUFTRAG_ID,
	LAGERAUFGABE_ID,
	LAGERAUFGABE_POS_ID,
	MANDANT_LAGERAUFGABE_POS,
	LAGERNUMMER_ID,
	LAGERSORTIMENT_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	LIEF_PAL_TYP_ID,
	EWM_GV_GRP_ID,
	EWM_EXC_KATEGORIE_ID,
	DAT_LIEF_SOLL,
	WG_VERKETT_LIEF,
	WERBEWARE_ID,
	STATUS_ID,
	LAGERPROZESSART_ID,
	ART_ID,
	ARTIKELSORTIMENT_ID,
	AUSNAHME_CODE,
	BUS_KONTEXT,
	AUSFUEHR_SCHRITT_ID,
	MENGE_IST_BME,
	MANUELL_ERZEUGT_FG,
	LAGERAUFTRAG_STATUS_ID,
	LAGERAUFTRAG_HAS_EXC_1_FG,
	LAGERAUFTRAG_HAS_EXC_2_FG,
	LAGERAUFTRAG_HAS_EXC_3_FG
) AS
-- 05.03.2021, SPEC0105396, AP0080760, dknop, initiale Anlage_1, based on the logic from N.Wagner
-- 05.03.2021, SPEC0105396, AP0080760, dknop, adding ordim_c.lagernummer
-- 18.03.2021, SPEC0105396, AP0080760, nwag2310, added join to lagerauftrag_1 to get lagerauftrag_status_id        
-- 24.03.2021, SPEC0105396, AP0080760, nwag2310, lief_beleg_id from refdoc instead of proci_o + dedup
-- 30.06.2021, SPEC0105396, AP0080760, dknop, adding artikelsortiment
-- 29.10.2021, SPEC0105396, AP0080760, dknop, adding ordim_c.werbeware_id, formatting updates
-- 2022-04-25, dknop, update logic for improving performance
-- 2022-05-13, dknop, adding lagerauftrag_has_exc_1_fg, lagerauftrag_has_exc_2_fg , lagerauftrag_has_exc_3_fg 
-- 2022-06-20, dknop removing QUALIFY ROW_NUMBER() as this is causing some rows disapear
-- 2023-04-06, dknop, adding limit for 2 years, adding lagernummer_id in join to lagerauftrag_1
-- 2023-04-13, nwag2310, all logic moved to backend
--2023-06-15, dknop, adding 'where' condition, at least one record for a given lagerauftrag_id has to have some content in ewm_gv_grp_id
SELECT
	v0.MANDANT_ID,
	v0.LAGERAUFTRAG_ID,
	v0.LAGERAUFGABE_ID,
	v0.LAGERAUFGABE_POS_ID,
	v0.mandant_id || v0.lageraufgabe_id || v0.lageraufgabe_pos_id AS MANDANT_LAGERAUFGABE_POS,
	v0.LAGERNUMMER_ID,
	v0.LAGERSORTIMENT_ID,
	v0.LIEF_BELEG_ID,
	v0.LIEF_BELEG_POS_ID,
	v0.LIEF_PAL_TYP_ID,
	v0.EWM_GV_GRP_ID,
	v0.EWM_EXC_KATEGORIE_ID,
	v0.DAT_LIEF_SOLL,
	v0.WG_VERKETT_LIEF,
	v0.WERBEWARE_ID,
	v0.LAGERAUFGABE_STATUS_ID,
	v0.LAGERPROZESSART_ID,
	v0.ART_ID,
	v0.ARTIKELSORTIMENT_ID,
	v0.AUSNAHME_CODE,
	v0.BUS_KONTEXT,
	v0.AUSFUEHR_SCHRITT_ID,
	v0.MENGE_IST_BME,
	v0.MANUELL_ERZEUGT_FG,
	v0.LAGERAUFTRAG_STATUS_ID,
	v0.LAGERAUFTRAG_HAS_EXC_1_FG,
	v0.LAGERAUFTRAG_HAS_EXC_2_FG,
	LAGERAUFTRAG_HAS_EXC_3_FG
FROM dbp_view.v_skipped_positions_ewm_1 v0
WHERE (mandant_id,lagernummer_id, lagerauftrag_id)  IN 
         (
        SELECT 
        mandant_id, lagernummer_id, lagerauftrag_id
        FROM dbp_view.v_skipped_positions_ewm_1   
        GROUP BY 1,2,3 HAVING  MAX(CASE WHEN  ewm_gv_grp_id <> '' THEN 1 ELSE 0 END ) > 0
        );