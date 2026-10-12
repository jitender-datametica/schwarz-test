CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IN_LIEFERANT_2(
	IN_LIEF_ID,
	MANDANT_ID,
	LIEF_NAME_1,
	LIEF_NAME_2,
	GP_ORT,
	GP_PLZ,
	IN_LIEF_NR,
	MANDANT_ID_WERK,
	SYSTEM_ID,
	LOESCH_FG,
	IN_LIEF_ID_INT,
	SUBKATEGORIE_1_ID,
	KONZERN_ID,
	WERK_ID,
	BIS_RELEVANT_FG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   in_lief_id, mandant_id, lief_name_1, lief_name_2, gp_ort,
   gp_plz, in_lief_nr, mandant_id_werk, system_id, loesch_fg, in_lief_id_int,
   subkategorie_1_id, konzern_id, werk_id, bis_relevant_fg
   FROM dbp_view.v_in_lieferant_2;