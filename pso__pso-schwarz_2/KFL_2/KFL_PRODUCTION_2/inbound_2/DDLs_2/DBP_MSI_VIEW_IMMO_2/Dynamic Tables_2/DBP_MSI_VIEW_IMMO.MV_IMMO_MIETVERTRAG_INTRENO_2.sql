CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_INTRENO_2(
	MANDANT_ID,
	MV_INTRENO,
	MIETVERTRAG_NR,
	PARTNER_ID,
	KONZESSIONAER_ID,
	DAT_VON,
	DAT_BIS
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT DISTINCT
    v3.mandant_id, v3.mv_intreno, v3.mietvertrag_nr, v3.partner_id, v3.partner_id AS konzessionaer_id, v2.dat_von, v2.dat_bis

   FROM dbp_view.v_immo_mietvertrag_per_2  v3
   LEFT JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 AS v2
   ON v3.mandant_id = v2.mandant_id AND v3.mv_intreno = v2.mv_intreno;