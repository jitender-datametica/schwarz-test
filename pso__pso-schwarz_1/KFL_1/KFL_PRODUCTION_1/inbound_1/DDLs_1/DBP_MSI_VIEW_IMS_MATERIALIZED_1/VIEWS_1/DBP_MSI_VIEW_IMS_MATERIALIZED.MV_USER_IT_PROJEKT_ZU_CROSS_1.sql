create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_USER_IT_PROJEKT_ZU_CROSS_1(
	IT_PROJEKT_ID,
	USER_ID,
	SEC_FG
) as
-- 10.05.2021 twie: SPEC0081686 Kombination aller user mit allen IT Projekten für Transaktion Zuordnungsbericht
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   v01.it_projekt_id,
   LOWER(v02.user_id) AS user_id,
   CASE WHEN v03.user_id IS NULL THEN 0 ELSE 1 END AS sec_fg

   FROM dbp_view.v_it_projekt_1 v01
   CROSS JOIN

   ( SELECT user_id FROM dbp_security.l_msi_user_1
   WHERE msi_produkt_bez = 'IMS'
   ) v02
   LEFT JOIN dbp_security.l_ims_user_it_projekt_1 v03
   ON v01.it_projekt_id = v03.it_projekt_id
   AND v02.user_id = v03.user_id;