CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_USER_SEC_KZ_ZU_CROSS
(
	SEC_KZ,
	USER_ID,
	SEC_FG
) AS
--28.09.2022 twie: SPEC0167837 Kombination aller User mit allen Sec KZ für Transaktion Zuordnungsbericht
--25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT

   v01.sec_kz,
   LOWER(v02.user_id) AS user_id,
   CASE WHEN v03.user_id IS NULL THEN 0 ELSE 1 END AS sec_fg

   FROM dbp_msi_v_view.v_l_kmr_security v01

   CROSS JOIN
   ( SELECT user_id FROM dbp_security.l_msi_user
   WHERE msi_produkt_bez = 'KMR'
   ) v02
   
   LEFT JOIN dbp_msi_v_view.v_ts_kmr_user_sec_kz_zu v03
   ON v01.sec_kz = v03.sec_kz
   AND v02.user_id = v03.user_id;