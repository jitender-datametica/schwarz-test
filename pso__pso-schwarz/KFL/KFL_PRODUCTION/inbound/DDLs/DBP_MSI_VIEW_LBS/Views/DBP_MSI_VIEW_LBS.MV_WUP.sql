CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WUP(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WUP_STANDORT,
	DAT_VON,
	DAT_BIS,
	DAT_QBM_UMSTELLUNG,
	DAT_EROEFFNUNG,
	WUP_PLZ,
	REGION_ID,
	KREISTYP_GRUPPE_ID,
	BREITENGRAD,
	LAENGENGRAD,
	WUP_TYP_ID,
	UEBERNAHME_VON,
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE,
	DAT_UMSTELLUNG_WAAGE,
	KUNDENFAKTOR,
	VZ_WUP_ID,
	VKL_ID,
	VS_ID,
	VF_ID,
	GF_ID,
	HL_ID,
	WM_ID,
	UMZUGSFILIALE_FG
) AS SELECT
     v01.mandant_id
    ,v01.wup_id
    ,v01.nb_id
    ,TRIM(v01.wup_id || ' ' || v01.wup_standort) AS wup_standort
    --SPEC0207781 sschuecke 18.07.2023 / vorher nur dat_von
    ,COALESCE(v01.dat_von_alt, v01.dat_von) AS dat_von
    ,v01.dat_bis
    ,v01.dat_qbm_umstellung
    --SPEC0207781 sschuecke 18.07.2023 / vorher nur dat_eroeffnungr dat_eroeffnung
    ,COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) AS dat_eroeffnung
    ,v01.wup_plz
    ,v02.region_id
    ,v01.kreistyp_gruppe_id
    ,v01.breitengrad
    ,v01.laengengrad
    ,v01.wup_typ_id
    ,v01.uebernahme_von
    ,v01.verkaufsflaeche
    ,v01.betriebsflaeche
    ,v01.dat_umstellung_waage
    ,v01.kundenfaktor
    ,v01.vz_wup_id
    --SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik VKL_ID bzgl geschossene Filialen
    ,CASE WHEN (v01.dat_bis <> '9999-12-31' AND v01.umzugsfiliale_fg = 1 AND v01.vkl_id < 0) THEN COALESCE(v03.vkl_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
      WHEN (v01.dat_bis <> '9999-12-31' AND v01.umzugsfiliale_fg = 0 AND v01.vkl_id < 0) THEN (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1
      ELSE v01.vkl_id 
      END AS vkl_id
    ,v01.vs_id
    ,v01.vf_id
    --SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik GF_ID bzgl geschossene Filialen
    ,CASE WHEN (v01.dat_bis <> '9999-12-31' AND v01.umzugsfiliale_fg = 1 AND v01.gf_id < 0) THEN COALESCE(v03.gf_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
      WHEN (v01.dat_bis <> '9999-12-31' AND v01.umzugsfiliale_fg = 0 AND v01.gf_id < 0) THEN (1000 + v01.mandant_id * 100 + v01.vs_id * 10) * -1
      ELSE v01.gf_id 
      END AS gf_id
    ,v01.hl_id
    ,v01.wm_id
    ,v01.umzugsfiliale_fg

FROM dbp_view.v_wup AS v01

LEFT JOIN dbp_view.v_vaus_wup v02
    ON  v01.mandant_id = v02.mandant_id
    AND v01.wup_id = v02.wup_id

--SPEC0212614 sschuecke 21.08.2023 / Anpassung Anzeige Logik VKL_ID bzgl geschossene Filialen
LEFT JOIN DBP_VIEW.V_WUP v03
    ON  v01.mandant_id = v03. mandant_id
    AND v01.wup_id = v03.wup_id_alt
    AND v01.nb_id = v03.nb_id

-- SPEC0152531 Erweiterung WHERE CLAUSE analog AIS_DE
WHERE (((v01.DAT_EROEFFNUNG < CURRENT_DATE OR v01.DAT_EROEFFNUNG< CURRENT_DATE +45) AND v01.DAT_VON IS NOT NULL)
       OR v01.NB_ID <> 0
       OR v01.WUP_ID = 9203)-- Filterung von Zentralfilialen
	     AND NOT v01.WUP_ID BETWEEN 1 AND 999 -- 20100330 Filterung der IWT Betriebe
	     AND v01.NB_ID <> 99;