CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IN_PSP_ELEMENT(
	MANDANT_ID,
	PSP_ID,
	PSP_ID_CHAR,
	PSP_BEZ,
	PC_ID,
	KRK_ID,
	BUCHUNGSKREIS_ID,
	GESCHAEFTSBEREICH_ID,
	DAT_ERFASST,
	TECHN_PLATZ_ID,
	DAT_AENDERUNG,
	IN_PROJEKT_ID,
	STATISTISCH_FG,
	BENUTZERFELD_1,
	BENUTZERFELD_2,
	BENUTZERFELD_4,
	DAT_ABSCHLUSS,
	PSP_END_NR,
	GEWERK_ID,
	PLAN_AKTIVIERUNGS_QUOTE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   mandant_id, psp_id, psp_id_char, psp_bez, pc_id, krk_id,
   buchungskreis_id, geschaeftsbereich_id, dat_erfasst, techn_platz_id,
   dat_aenderung, in_projekt_id, statistisch_fg, benutzerfeld_1,
   benutzerfeld_2, benutzerfeld_4, dat_abschluss, psp_end_nr, gewerk_id,
   plan_aktivierungs_quote
   FROM dbp_view.v_in_psp_element;