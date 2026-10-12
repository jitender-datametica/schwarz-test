CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_umlagerung_status_kz_2 (umlagerung_status_kz
OPTIONS(description='Kennzeichen für Umlagerungsstatus'), umlagerung_status_kz_bez
OPTIONS(description='Bezeichnung für Umlagerungsstatus'))
OPTIONS(DESCRIPTION = `LOOKUP FÜR KENNZEICHEN VON UMLAGERUNGSSTATUS`) AS SELECT umlagerung_status_kz,
 umlagerung_status_kz_bez
FROM (SELECT 'O' AS umlagerung_status_kz,
    'Offen' AS umlagerung_status_kz_bez
   UNION ALL
   SELECT 'S' AS umlagerung_status_kz,
    'Storniert' AS umlagerung_status_kz_bez
   UNION ALL
   SELECT 'W' AS umlagerung_status_kz,
    'WE' AS umlagerung_status_kz_bez);