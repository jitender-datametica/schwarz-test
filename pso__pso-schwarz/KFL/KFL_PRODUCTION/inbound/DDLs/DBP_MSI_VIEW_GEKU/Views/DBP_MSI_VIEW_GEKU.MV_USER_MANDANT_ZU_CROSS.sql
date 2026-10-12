CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_USER_MANDANT_ZU_CROSS
(
	MANDANT_ID,
	USER_ID,
	SEC_FG
) AS
--29.09.2022 twie: SPEC0167837 Kombination aller User mit allen Mandanten für Transaktion Zuordnungsbericht
--25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   v01.mandant_id,
   LOWER(v02.user_id) AS user_id,
   CASE WHEN v03.user_id IS NULL THEN 0 ELSE 1 END AS sec_fg

   FROM dbp_view.v_mandant v01

   CROSS JOIN
   ( SELECT user_id FROM dbp_security.l_msi_user
   WHERE msi_produkt_bez = 'KMR'
   ) v02

   LEFT JOIN dbp_security.user_mandant_msiprodukt_zu v03
   ON v01.mandant_id = v03.mandant_id
   AND v02.user_id = v03.user_id
   AND v03.msi_produkt_bez = 'KMR';