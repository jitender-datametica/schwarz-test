CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_WE_TP_WUP_ZUORDNUNG_1(
	MANDANT_ID,
	WIRTSCHAFTSEINHEIT_ID,
	WE_INTRENO,
	DAT_EROEFFNUNG,
	DAT_VON,
	DAT_BIS,
	GF_ID,
	GF_NAME,
	VERTRIEBSSCHIENE,
	VKL_ID,
	VKL_NAME,
	HL_ID,
	HL_NAME,
	BL_BAU_EINR_NAME,
	BETREUER_BAU_EINR_NAME,
	OL_VERMIETUNG_NAME,
	FRISCHE_BAECKER,
	DISCOUNT_BACKSHOP,
	KAUFLAND_BAECKEREI,
	FLEISCH_FG,
	IMBISS_FG,
	FISCH_FG,
	EIGENTUM_BEZ,
	FLAECHE_PARKPLAETZE,
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   w1.mandant_id, w1.wup_id AS wirtschaftseinheit_id, v1.we_intreno, w1.dat_eroeffnung, w1.dat_von, w1.dat_bis, gf1.gf_id, gf1.gf_name, vs1.vsvt_bez AS vertriebsschiene, w1.vkl_id, vkl1.vkl_name, w1.hl_id, hl1.hl_name, tp2.tp_bl_kbl_name       bl_bau_einr_name, tp2.tp_betreuer_kbl_name betreuer_bau_einr_name, tp2.tp_ol_vermietung     ol_vermietung_name, tp2.frische_baecker, tp2.discount_backshop, v2.backshop_system AS kaufland_baeckerei, CASE WHEN v2.bed_fleisch_fg=1 THEN 'Ja' ELSE 'Nein' END AS fleisch_fg, CASE WHEN v2.bed_imbiss_fg=1 THEN 'Ja' ELSE 'Nein' END AS imbiss_fg, CASE WHEN v2.bed_fisch_id =2 THEN 'SB'
   WHEN  v2.bed_fisch_id =3 THEN 'Bedienung'
   WHEN  v2.bed_fisch_id =4 THEN 'Bedienung/SB'
   ELSE '-' END AS fisch_fg, tp2.eigentum_bez, COALESCE(gfp.ginfo_flaeche_netto , 0 ) AS flaeche_parkplaetze, w1.verkaufsflaeche, w1.betriebsflaeche
   FROM dbp_view.v_wup_1  w1
   LEFT JOIN dbp_view.v_techn_platz_per_1 tp0
   ON w1.mandant_id = tp0.mandant_id
   AND w1.wup_id = tp0.wup_id
   AND tp0.techn_platz_ebene_id = 2
   AND tp0.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_techn_platz_ebene_2_per_1 tp2
   ON tp0.techn_platz_id = tp2.techn_platz_id
   AND tp2.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_ginfo_flaeche_per_1 gfp
   ON tp0.techn_platz_id = gfp.techn_platz_id
   AND gfp.ginfo_flaeche_id = 'PPL'
   AND gfp.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_hl_1 hl1
   ON w1.hl_id = hl1.hl_id
   AND w1.mandant_id = hl1.mandant_id
   LEFT JOIN dbp_view.v_vkl_1 vkl1
   ON w1.vkl_id = vkl1.vkl_id
   AND w1.mandant_id = vkl1.mandant_id
   LEFT JOIN dbp_view.v_gf_1 gf1
   ON vkl1.gf_id = gf1.gf_id
   AND vkl1.mandant_id = gf1.mandant_id
   AND gf1.ek_fg = 0
   LEFT JOIN dbp_view.v_vs_1 vs1
   ON w1.vs_id = vs1.vs_id
   AND w1.mandant_id = vs1.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_wirtschaftseinheit_1 v1
   ON w1.wup_id=v1.wirtschaftseinheit_id AND w1.mandant_id=v1.mandant_id
   LEFT JOIN dbp_msi_v_view.v_wup_denorm_1 AS v2
   ON w1.wup_id=v2.wup_id AND w1.mandant_id=v2.mandant_id

   WHERE w1.nb_id = 0
   AND w1.dat_eroeffnung > TO_DATE('1900-01-01','YYYY-MM_1-DD');