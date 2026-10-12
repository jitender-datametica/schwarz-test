create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WUP_1(
	WUP_ID,
	AKTUELL_WUP_ID,
	NB_ID,
	MANDANT_ID,
	LAND_ID,
	DAT_VON,
	WUP_TYP_ID,
	VS_ID,
	VW_ID,
	WUP_NAME_V,
	WUP_NAME_E,
	WUP_STANDORT,
	WUP_PLZ,
	WUP_STR,
	VF_ID,
	VKL_ID,
	GETRAENKEMARKT_FG,
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
	LEAD_MWST,
	REGION_ID,
	KUNDENFAKTOR,
	VZ_WUP_ID,
	QBM_ID,
	WUP_ID_ALT,
	BUCHUNGSKREIS_ID,
	VERKAUFSORGANISATION_ID,
	SYSTEM_ID,
	OPEN_FG,
	LAENGENGRAD,
	BREITENGRAD,
	KREISTYP_GRUPPE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 20130828 - kkaiser Wenn up_id nicht gefüllt, dann 0 und nb_id = -1, Bezeichnung  auf ''
-- 03.03.2017 twie: SPEC0020966 Bedingung nb_id -1 und vw_id 6 für WUP_1 8120 aufgenommen
-- 12.05.2017 twie: SPEC0023707 breiten/laengengrad für Geo
-- 15.08.2024 twie: SPEC0264080 aktuell_wup_id ergänzt als Elternattribut von wup_id (Filialumgliederung)
-- 20.11.2024 twie: SPEC0264080 Erweiterung Konzept um Umzugsfilialen. Hier ist im Gegensatz zur Filialumgliederung in der Tabelle keine Zusammenfassung über die aktuell_wup_id vorhanden
--					Stattdessen hat die neue Filiale im Feld wup_id_alt die alte wup_id als Zuordnung enthalten.
--					Somit kann bei der alten Filiale die aktuell_wup_id der neuen Filiale ermittelt und ausgegeben werden

                   SELECT
                   v01.wup_id,
                   --Bei Umzugsfilialen beinhaltet v02.aktuell_wup_id die ID der neuen Filiale, Standardfall ist v01.aktuell_wup_id
                   COALESCE (v02.aktuell_wup_id, v01.aktuell_wup_id) AS aktuell_wup_id,
                   v01.nb_id,
                   v01.mandant_id,
                   v01.land_id,
                   v01.dat_von,
                   v01.wup_typ_id,
                   v01.vs_id,
                   v01.vw_id,
                   v01.wup_name_v,
                   v01.wup_name_e,
                   CASE
                   WHEN v01.dat_bis < '9999-12-31'
                   --ASCII Codes stehen für geschweifte Klammern, wegen Darstellungsproblem in der View als Code
                   THEN CHR(123) || v01.wup_standort || CHR(125)
                   ELSE  v01.wup_standort
                   END wup_standort,
                   v01.wup_plz,
                   v01.wup_str,
                   v01.vf_id,
                   v01.vkl_id,
                   v01.getraenkemarkt_fg,
                   v01.hl_id,
                   v01.dat_bis,
                   v01.uebernahme_von,
                   v01.breakevenumsatz,
                   v01.systemrentabilitaet,
                   v01.verkaufsflaeche,
                   v01.betriebsflaeche,
                   v01.fleischsystem,
                   v01.preiskategorie_food,
                   v01.preiskategorie_nonfood,
                   v01.sortkategorie_food,
                   v01.sortkategorie_nonfood,
                   v01.sondermarkt,
                   v01.ref_wup_id,
                   v01.wm_id,
                   v01.kassentyp,
                   v01.lead_mwst,
                   v01.region_id,
                   v01.kundenfaktor,
                   v01.vz_wup_id,
                   v01.qbm_id,
                   v01.wup_id_alt,
                   v01.buchungskreis_id,
                   v01.verkaufsorganisation_id,
                   7 AS system_id,
                   CASE WHEN v01.dat_von <= CURRENT_DATE AND v01.dat_bis = '9999-12-31' THEN 1
                   ELSE
                   CASE WHEN v01.dat_bis < '9999-12-31'  THEN 2
                   ELSE
                   CASE WHEN v01.dat_von > CURRENT_DATE AND v01.dat_bis = '9999-12-31' THEN 3
                   ELSE 0
                   END
                   END
                   END AS open_FG,
                   v01.laengengrad,
                   v01.breitengrad,
                   v01.kreistyp_gruppe_id
                   FROM dbp_view.v_wup_1 v01
                   
                   --Bei Umzugsfilialen: Den Datensatz der neuen Filiale zuordnen, dieser beinhaltet die alte wup_id
                   LEFT JOIN dbp_view.v_wup_1 v02
			   		ON v01.mandant_id = v02. mandant_id
			   		AND v01.wup_id = v02.wup_id_alt
			   		AND v01.nb_id = v02.nb_id

                   WHERE  v01.mandant_id  = 1

                   -- 07.07.10: NB_1 99 IWT aufgenommen
                   AND (v01.nb_id IN (0,-111,2, 99)
                   OR (v01.wup_id = 0 AND v01.nb_id = -1)
                   --für WUP_1 8120 Internet Direktversand
                   OR (v01.nb_id = -1 AND v01.vw_id = 6))
;
