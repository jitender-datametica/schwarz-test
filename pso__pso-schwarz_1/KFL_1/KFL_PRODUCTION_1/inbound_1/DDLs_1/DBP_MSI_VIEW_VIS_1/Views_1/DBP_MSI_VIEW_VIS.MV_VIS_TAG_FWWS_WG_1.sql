CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_vis_tag_fwws_wg_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	BEZUGSWEG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	DAT,
	KJWO,
	KJMO,
	GJ,
	AKT_TAG,
	DISPOMERKMAL,
	ANZ_ARTIKEL_AUTODISPO,
	ANZ_ARTIKEL_MARKT_GELISTET_OKD,
	ANZ_ARTIKEL_MARKT_GELISTET,
	ANZ_ARTIKEL_EXC209,
	ANZ_ARTIKEL_EXC214,
	ANZ_ARTIKEL_AUTODISPO_DM12,
	SUM_ARTIKEL_AUTODISPO,
	SUM_ARTIKEL_MARKT_GELISTET_OKD,
	SUM_ARTIKEL_MARKT_GELISTET,
	ANZ_ARTIKEL_MARKT,
	SUM_ARTIKEL_MARKT
) AS

	-- FAKT-AGGREGAT FWWS Autodispo (Anz. Artikel_1) pro Woche_1/Tag_1 - Markt/Abt_1/WG
	-- Datenumfang:
	-- 2010KW37 INITIAL
	-- 2010KW47 Anpassung nur Autodispo
	-- 2012KW37 Review: Erweiterung Bezugsweg; Spaltennamen;  Einkaufsthemen
	--20190626 mcie, added sum aggregation to all KPIs
	-- 20200522 snik1809 - added dispomerkmal AP0047448-SPEC0077512
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
 

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																AS wup_id
 , v01.bezugsweg_id
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.dat
 , v01.kjwo
 , v01.kjmo
 , v01.gj
 , v01.akt_tag
 , v01.dispomerkmal
 , SUM(CAST(v01.anz_artikel_autodispo AS BIGINT)) 									AS anz_artikel_autodispo
 , SUM(v01.anz_artikel_markt_gelistet_okd) 											AS anz_artikel_markt_gelistet_okd
 , SUM(v01.anz_artikel_markt_gelistet) 												AS anz_artikel_markt_gelistet
 , SUM(v01.anz_artikel_exc209) 														AS anz_artikel_exc209
 , SUM(v01.anz_artikel_exc214) 														AS anz_artikel_exc214
 , SUM(v01.anz_artikel_autodispo_dm12) 												AS anz_artikel_autodispo_dm12
 , SUM(CAST(v01.sum_artikel_autodispo AS BIGINT))									AS sum_artikel_autodispo
 , SUM(v01.sum_artikel_markt_gelistet_okd) 											AS sum_artikel_markt_gelistet_okd
 , SUM(v01.sum_artikel_markt_gelistet) 												AS sum_artikel_markt_gelistet
 , SUM(0) 																			AS anz_artikel_markt
 , SUM(0) 																			AS sum_artikel_markt
FROM dbp_msi_data.vis_tag_fwws_wg_1	v01
 
INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
 
 GROUP BY
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 
 , v01.bezugsweg_id
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.dat
 , v01.kjwo
 , v01.kjmo
 , v01.gj
 , v01.akt_tag
 , v01.dispomerkmal
;