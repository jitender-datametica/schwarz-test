CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WUP_2(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	LAND_ID,
	DAT_VON,
	WUP_TYP_ID,
	WUP_NAME_V,
	WUP_NAME_E,
	WUP_STANDORT,
	WUP_PLZ,
	WUP_STR,
	VF_ID,
	VKL_ID,
	HL_ID,
	DAT_BIS,
	UEBERNAHME_VON,
	BREAKEVENUMSATZ,
	SYSTEMRENTABILITAET,
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE,
	FLEISCHSYSTEM,
	PREISKATEGORIE_FOOD,
	PREISKATEGORIE_NONFOOD,
	SORTKATEGORIE_FOOD,
	SORTKATEGORIE_NONFOOD,
	SONDERMARKT,
	REF_WUP_ID,
	WM_ID,
	KASSENTYP,
	DAT_QBM_UMSTELLUNG,
	LEAD_MWST,
	REGION_ID,
	KUNDENFAKTOR,
	VZ_WUP_ID,
	MARKT,
	QBM_ID,
	GETRAENKEMARKT_FG,
	VS_ID,
	BUCHUNGSKREIS_ID,
	VERKAUFSORGANISATION_ID,
	BREITENGRAD,
	LAENGENGRAD,
	AKTUELL_WUP_ID,
	IS_AKT_WUP_ID_FG,
	DAT_WANKO_VON
) AS
--2024-07-24,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id, is_akt_wup_id_fg
--2024-11-07, dknop, adding dat_wanko_von
   SELECT
   w.wup_id,
   w.nb_id,
   w.mandant_id, w.land_id,
   w.dat_von, w.wup_typ_id,
   w.wup_name_v, w.wup_name_e,
   w.wup_standort, wup_plz, wup_str,
   w.vf_id, w.vkl_id, w.hl_id, w.dat_bis,
   w.uebernahme_von, w.breakevenumsatz,
   w.systemrentabilitaet, w.verkaufsflaeche,
   w.betriebsflaeche, w.fleischsystem,
   w.preiskategorie_food,
   w.preiskategorie_nonfood, w.sortkategorie_food, w.sortkategorie_nonfood, w.sondermarkt,
   w.ref_wup_id, w.wm_id,
   w.kassentyp, w.dat_qbm_umstellung, w.lead_mwst, w.region_id, w.kundenfaktor, w.vz_wup_id, TRIM(w.wup_id||' ' ||w.wup_standort),
   (CASE WHEN w.dat_qbm_umstellung IS NOT NULL THEN 1 ELSE 0 END) qbm_id, w.getraenkemarkt_fg, w.vw_id, w.buchungskreis_id,
   w.verkaufsorganisation_id, w.breitengrad, w.laengengrad,
   w.aktuell_wup_id,
   CASE WHEN w.aktuell_wup_id = w.wup_id THEN 1 ELSE 0 END AS is_akt_wup_id_fg,
   COALESCE(dat_wanko_von, DATE'9999-12-31') AS dat_wanko_von
   FROM dbp_view.v_wup_2 w
   LEFT JOIN (SELECT v01.mandant_id, v00.wup_id, MIN(COALESCE(v00.dat_tms_wanko, DATE'9999-12-31')) AS dat_wanko_von 
         FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM_2 v00
         JOIN dbp_view.v_tms_gp_2 v01 ON v01.mandant_id=v00.mandant_id
         AND TRY_CAST(v01.tms_gp_id AS NUMBER) = v00.wup_id
         AND v00.nb_id=-111
         WHERE tms_gp_typ_cd='L' 
         GROUP BY v01.mandant_id,  v00.wup_id)dat_wanko
  ON w.wup_id = dat_wanko.wup_id
  AND w.mandant_id = dat_wanko.mandant_id;