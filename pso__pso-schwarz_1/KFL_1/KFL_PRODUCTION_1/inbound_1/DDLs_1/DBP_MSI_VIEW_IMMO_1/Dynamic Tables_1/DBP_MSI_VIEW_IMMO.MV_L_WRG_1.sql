CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_WRG_1(
	WRG_ID,
	KURSTYP_ID,
	DAT_VON,
	DAT_BIS,
	KURS_ZU_EURO
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS


   SELECT
   von_wrg_id AS wrg_id, kurstyp_id, dat_von, dat_bis, 1/umrechnungskurs AS kurs_zu_euro
   FROM dbp_view.v_kurs_1
   WHERE dat_bis = '9999-12-31' AND kurstyp_id=3;