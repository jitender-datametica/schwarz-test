CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WUP_2
(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	AKTUELL_WUP_ID,
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
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE,
	PREISKATEGORIE_FOOD,
	PREISKATEGORIE_NONFOOD,
	SORTKATEGORIE_FOOD,
	SORTKATEGORIE_NONFOOD,
	SONDERMARKT,
	REF_WUP_ID,
	WM_ID,
	KASSENTYP,
	DAT_QBM_UMSTELLUNG,
	KREISTYP_GRUPPE_ID,
	DAT_UMSTELLUNG_WAAGE,
	LEAD_MWST,
	REGION_ID,
	VZ_WUP_ID,
	MARKT,
	GETRAENKEMARKT_FG,
	VS_ID,
	VERKAUFSORGANISATION_ID,
	ADRESSE_ID,
	LAENGENGRAD,
	BREITENGRAD
)
AS
--07.08.2024 twie: SPEC0262756 aktuell_wup_id ergänzt als Elternattribut von wup_id (Filialumgliederung)
--					laengengrad und breitengrad ergänzt, da in MSI verwendet

   SELECT
   wup_id,
   nb_id,
   mandant_id,
   aktuell_wup_id,
   land_id,
   CASE WHEN wup_id = 2660 THEN '2009-09-17' ELSE dat_von END  AS dat_von, 
   wup_typ_id,
   wup_name_v,
   wup_name_e,
   wup_standort,
   wup_plz,
   wup_str,
   vf_id,
   vkl_id,
   hl_id,
   dat_bis,
   uebernahme_von,
   verkaufsflaeche,
   betriebsflaeche,
   preiskategorie_food,
   preiskategorie_nonfood,
   sortkategorie_food,
   sortkategorie_nonfood,
   sondermarkt,
   ref_wup_id,
   wm_id,
   kassentyp,
   dat_qbm_umstellung,
   kreistyp_gruppe_id,
   dat_umstellung_waage,
   lead_mwst,
   region_id,
   vz_wup_id,
   TRIM(wup_id || ' ' || wup_standort)  AS Markt,
   getraenkemarkt_fg,
   vs_id,
   verkaufsorganisation_id,
   adresse_id,
   laengengrad,
   breitengrad
   
  FROM dbp_view.v_wup_2

  WHERE mandant_id = 1
  AND (((dat_eroeffnung < CURRENT_DATE OR dat_eroeffnung< CURRENT_DATE +45)  AND dat_von IS NOT NULL) OR nb_id <> 0 OR wup_id = 9203)
  -- Filterung von Zentralfilialen
  AND NOT wup_id BETWEEN 1 AND 999
  -- 20100330 Filterung der IWT Betriebe
  AND nb_id <> 99;