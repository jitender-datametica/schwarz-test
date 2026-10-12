CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_USER_MANDANT_ZU_CROSS
(
	MANDANT_ID,
	USER_ID,
	SEC_FG
)
AS
-- 11.12.2018 twie: SPEC0044926 Zuordnung User - Mandant für Pflegebericht (alle Kombinationen)
-- 29.01.2024 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   v01.mandant_id,
   LOWER(v02.user_id) AS user_id,
   CASE WHEN v03.user_id IS NULL THEN 0 ELSE 1 END AS sec_fg

   FROM dbp_view.v_mandant v01
   CROSS JOIN

   ( SELECT user_id FROM dbp_security.l_msi_user
   WHERE msi_produkt_bez = 'IMS'
   ) v02
   LEFT JOIN dbp_security.user_mandant_msiprodukt_zu v03
   ON v01.mandant_id = v03.mandant_id
   AND v02.user_id = v03.user_id
   AND v03.msi_produkt_bez = 'IMS'
   ;