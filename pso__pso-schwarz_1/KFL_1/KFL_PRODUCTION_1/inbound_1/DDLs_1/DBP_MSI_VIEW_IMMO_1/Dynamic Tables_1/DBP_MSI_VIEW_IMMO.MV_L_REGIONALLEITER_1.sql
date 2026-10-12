CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_REGIONALLEITER_1(
	REGIONALLEITER_ID,
	NAME1,
	NAME2
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   
   v0.partner_id AS regionalleiter_id, MAX(v0.vorname) AS name1, MAX(v0.nachname) AS name2
   FROM dbp_view.v_immo_l_partner_1 v0
   INNER JOIN dbp_view.v_immo_we_partner_rolle_zu_per_1 v1
   ON
   
   v0.partner_id = v1.partner_id
   WHERE "CURRENT_DATE" <= v1.dat_bis
   AND v1.rolle_kz = 'ZI0105'
   GROUP BY 1

   UNION ALL

   SELECT DISTINCT
   'n.v.' AS regionalleiter_id, 'ohne Zuordnung' AS name1, '' AS name2
   FROM dbp_view.v_mandant_1;