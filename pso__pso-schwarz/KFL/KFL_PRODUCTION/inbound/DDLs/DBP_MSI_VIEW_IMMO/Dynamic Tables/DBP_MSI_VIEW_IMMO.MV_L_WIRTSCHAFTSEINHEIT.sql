CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_WIRTSCHAFTSEINHEIT(
	MANDANT_ID,
	WE_INTRENO,
	WIRTSCHAFTSEINHEIT_ID,
	WIRTSCHAFTSEINHEIT_BEZ,
	WE_OBJEKT_NR,
	DAT_EROEFFNUNG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   

   SELECT
   v0.mandant_id, v0.we_intreno, CASE WHEN LENGTH(v0.wirtschaftseinheit_id)=3 THEN '0'||v0.wirtschaftseinheit_id ELSE v0.wirtschaftseinheit_id END AS wirtschaftseinheit_id, v0.wirtschaftseinheit_bez, v0.we_objekt_nr, v0.dat_eroeffnung
   FROM dbp_view.v_immo_wirtschaftseinheit v0

   WHERE "CURRENT_DATE" BETWEEN v0.dat_we_gueltig_von AND v0.dat_we_gueltig_bis;