CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETOBJEKT_MESSUNG_2(
	MANDANT_ID,
	MO_INTRENO,
	BEMESSUNG_ART_ID,
	DAT_BIS,
	DAT_VON,
	GROESSE,
	GROESSE_EINHEIT
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   mandant_id, mo_intreno, bemessung_art_id, dat_bis, dat_von, groesse, groesse_einheit
   FROM dbp_view.v_immo_mietobjekt_messung_2
   WHERE "CURRENT_DATE" BETWEEN dat_von AND dat_bis
   AND bemessung_art_id IN ('0300','0310','0320','0380');