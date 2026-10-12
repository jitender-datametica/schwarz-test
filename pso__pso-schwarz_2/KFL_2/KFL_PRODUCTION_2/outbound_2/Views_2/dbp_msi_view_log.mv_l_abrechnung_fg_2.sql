CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_abrechnung_fg_2 (abrechnung_fg, abrechnung_fg_s,
abrechnung_fg_desc) AS SELECT 1 AS abrechnung_fg,
 'X' AS abrechnung_fg_s,
 'Rechnungslauf abgeschlossen (Hydra)' AS abrechnung_fg_desc
UNION ALL
SELECT 0 AS abrechnung_fg,
 ' ' AS abrechnung_fg_s,
 'Rechnungslauf noch offen (Hydra)' AS abrechnung_fg_desc;