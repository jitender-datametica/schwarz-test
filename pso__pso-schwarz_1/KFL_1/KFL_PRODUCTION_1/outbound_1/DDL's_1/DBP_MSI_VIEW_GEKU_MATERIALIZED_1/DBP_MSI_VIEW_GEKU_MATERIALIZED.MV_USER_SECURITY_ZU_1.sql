-- 15.01.2019 twie: SPEC0046912 Zuordnung von MSI User zu Mandant_1 und Security Kennzeichen

-- 25.01.2024 twie: NSR4272151 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

-- 12.10.2022 twie: SPEC0167837 neue Security Steuerung, User kann im TS Bericht Mandant_1 (1) und Sec_KZ (N) unabhängig auswählen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_user_security_zu_1 (user_id, mandant_id, sec_kz)
AS SELECT LOWER(V01.user_id) AS user_id,
 V02.mandant_id,
 V01.sec_kz
FROM kfl_production_dbp_msi_v_view.v_ts_kmr_user_sec_kz_zu_1 AS V01
 INNER JOIN kfl_production_dbp_security.user_mandant_msiprodukt_zu_1 AS V02 ON V01.user_id = V02.user_id AND V02.msi_produkt_bez
    = 'KMR';