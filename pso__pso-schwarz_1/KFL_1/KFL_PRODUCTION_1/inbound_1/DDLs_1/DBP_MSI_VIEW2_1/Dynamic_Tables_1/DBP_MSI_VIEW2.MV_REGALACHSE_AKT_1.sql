CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_REGALACHSE_AKT_1
(
	AKTIV_FG,
	ART_ID,
	DISPLAY_ART_ID,
	EK_MEP,
	FACHBODEN_NR,
	FACHBODEN_POS,
	FBB_NR,
	KAPAZITAET,
	KAPAZITAET_FAKTOR,
	KAPAZITAET_MENGE_EINH_ID,
	MANDANT_ID,
	NB_ID,
	REGIONAL_KZ,
	SOLL_IST_KZ,
	VK_BRUTTO,
	VK_NETTO,
	WUP_ID,
	REGALACHSE_FLAECHE
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
   aktiv_fg,
   art_id,
   display_art_id,
   ek_mep,
   fachboden_nr,
   fachboden_pos,
   fbb_nr,
   kapazitaet,
   kapazitaet_faktor,
   kapazitaet_menge_einh_id,
   mandant_id,
   nb_id,
   regional_kz,
   soll_ist_kz,
   vk_brutto,
   (vk_brutto / (100.000 + mwst)) * 100 AS vk_netto,
   wup_id,
   regalachse_flaeche

FROM dbp_view.v_regalachse_akt_1
WHERE mandant_id = 1
AND aktiv_fg = 1;

