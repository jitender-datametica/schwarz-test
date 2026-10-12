create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_USER_MANDANT_MSIPRODUKT_ZU(
	USER_ID,
	MANDANT_ID,
	LOESCH_FG
) as
   SELECT
   sub.user_id, sub.mandant_id, MIN(sub.loesch_fg) AS loesch_fg 
   FROM

   
   (SELECT v01.user_id, v02.mandant_id, '1' AS loesch_fg

   FROM dbp_security.l_msi_user v01
   CROSS JOIN dbp_view.v_mandant v02
   WHERE msi_produkt_bez = 'IOS'
   GROUP BY 1,2,3

   UNION
   SELECT user_id, mandant_id,
   '0' AS loesch_fg
   FROM dbp_security.user_mandant_msiprodukt_zu
   WHERE msi_produkt_bez = 'IOS'
   )  sub

   GROUP BY 1,2;