CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_KONZESSIONAER(
	KONZESSIONAER_ID,
	PARTNER_ID,
	VERBUND_KZ,
	NAME1,
	NAME2,
	KONZESSIONAER_BEZ,
	KONZ_ADRESSE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   
   v0.partner_id AS konzessionaer_id, v0.partner_id, v0.verbund_kz, MAX(v0.vorname) AS name1, MAX(v0.nachname) AS name2, CASE WHEN name2 IS NULL THEN name1
   ELSE (name1 || ' ' || name2)  END AS konzessionaer_bez, CASE WHEN v0.plz IS NULL OR v0.plz='' THEN
   v0.plz||' '||v0.ort||' '||v0.strasse||' '||v0.haus_nr ELSE
   v0.plz||' '||v0.ort||','||''||' '||v0.strasse||' '||v0.haus_nr END AS konz_adresse

   FROM dbp_view.v_immo_l_partner v0
   INNER JOIN dbp_view.v_immo_mv_partner_rolle_zu v1
   ON
   
   v0.partner_id = v1.partner_id
   GROUP BY 1,2,3,7

   UNION ALL

   SELECT DISTINCT
   
   '' AS konzessionaer_id, '' AS partner_id, '' AS name1, '' AS name2, '' AS konzessionaer_bez, '' AS verbund_kz, '' AS konz_adresse
   FROM dbp_view.v_mandant;