CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_USER_IT_PROJEKT_ZU_CROSS
(
	IT_PROJEKT_ID,
	USER_ID,
	SEC_FG
)
AS
-- 10.05.2021 twie: SPEC0081686 Kombination aller user mit allen IT Projekten für Transaktion Zuordnungsbericht
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   v01.it_projekt_id,
   LOWER(v02.user_id) AS user_id,
   CASE WHEN v03.user_id IS NULL THEN 0 ELSE 1 END AS sec_fg

   FROM dbp_view.v_it_projekt v01
   CROSS JOIN

   ( SELECT user_id FROM dbp_security.l_msi_user
   WHERE msi_produkt_bez = 'IMS'
   ) v02
   LEFT JOIN dbp_security.l_ims_user_it_projekt v03
   ON v01.it_projekt_id = v03.it_projekt_id
   AND v02.user_id = v03.user_id
   ;