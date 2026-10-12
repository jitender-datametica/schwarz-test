CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_PARTNER(
	PARTNER_ID,
	KONZESSIONAER_ID,
	ANREDE,
	VORNAME,
	NACHNAME,
	GEBIET_ID,
	VERBUND_KZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   partner_id, partner_id AS konzessionaer_id, anrede, vorname, nachname, gebiet_id, verbund_kz
   FROM dbp_view.v_immo_l_partner

   UNION

   SELECT DISTINCT

   '' AS partner_id, '-1' AS konzessionaer_id, '' AS anrede, '' AS vorname, '' AS nachname, NULL AS gebiet_id, '' AS verbund_kz
   FROM dbp_view.v_mandant;