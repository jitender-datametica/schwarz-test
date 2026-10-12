CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_F_KURS_2(
	DAT_BIS,
	DAT_VON,
	KURSTYP_ID,
	NACH_WRG_ID,
	VON_WRG_ID,
	UMRECHNUNGSKURS,
	KURS_2
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   dat_bis, dat_von, kurstyp_id, nach_wrg_id, von_wrg_id, umrechnungskurs, TRUNC(1/umrechnungskurs) AS kurs_2
   FROM dbp_view.v_kurs_2
   WHERE dat_bis = '9999-12-31' AND kurstyp_id=3;