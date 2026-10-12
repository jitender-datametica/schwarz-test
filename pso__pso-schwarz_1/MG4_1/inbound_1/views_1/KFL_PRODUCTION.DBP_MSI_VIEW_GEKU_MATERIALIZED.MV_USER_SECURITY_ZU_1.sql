create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_USER_SECURITY_ZU_1(
	USER_ID,
	MANDANT_ID,
	SEC_KZ
) as
-- 15.01.2019 twie: SPEC0046912 Zuordnung von MSI User zu Mandant_1 und Security Kennzeichen
-- 12.10.2022 twie: SPEC0167837 neue Security Steuerung, User kann im TS Bericht Mandant_1 (1) und Sec_KZ (N) unabhängig auswählen
-- 25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
   LOWER(v01.user_id) AS user_id
  ,v02.mandant_id
  ,v01.sec_kz

   FROM dbp_msi_v_view.v_ts_kmr_user_sec_kz_zu_1 v01
   
   INNER JOIN dbp_security.user_mandant_msiprodukt_zu_1 v02
   ON v01.user_id = v02.user_id
   AND v02.msi_produkt_bez = 'KMR';