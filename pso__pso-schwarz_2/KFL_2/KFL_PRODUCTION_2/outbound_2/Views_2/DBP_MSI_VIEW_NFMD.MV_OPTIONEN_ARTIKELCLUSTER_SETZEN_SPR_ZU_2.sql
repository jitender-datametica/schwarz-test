CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_optionen_artikelcluster_setzen_spr_zu_2 AS SELECT 0 AS
 option_artikelcluster_id,
 'Gültig ab' AS beschreibung,
 'Gültig ab' AS beschreibung_de,
 'Valid from' AS beschreibung_cz,
 'Valid from' AS beschreibung_pl,
 'Valid from' AS beschreibung_sk,
 'vrijedi od' AS beschreibung_hr,
 'Valid from' AS beschreibung_ro,
 'Valid from' AS beschreibung_bg,
 'Valid from' AS beschreibung_en
UNION ALL
SELECT 1 AS option_artikelcluster_id,
 'Rabatt' AS beschreibung,
 'Rabatt' AS beschreibung_de,
 'Discount' AS beschreibung_cz,
 'Discount' AS beschreibung_pl,
 'Discount' AS beschreibung_sk,
 'popust' AS beschreibung_hr,
 'Discount' AS beschreibung_ro,
 'Discount' AS beschreibung_bg,
 'Discount' AS beschreibung_en
UNION ALL
SELECT 2 AS option_artikelcluster_id,
 'Gültig ab + Rabatt' AS beschreibung,
 'Gültig ab + Rabatt' AS beschreibung_de,
 'Valid from + Discount' AS beschreibung_cz,
 'Valid from + Discount' AS beschreibung_pl,
 'Valid from + Discount' AS beschreibung_sk,
 'vrijedi od + popust' AS beschreibung_hr,
 'Valid from + Discount' AS beschreibung_ro,
 'Valid from + Discount' AS beschreibung_bg,
 'Valid from + Discount' AS beschreibung_en
UNION ALL
SELECT 3 AS option_artikelcluster_id,
 'auf empf. VK_2 zurücksetzen' AS beschreibung,
 'auf empf. VK_2 zurücksetzen' AS beschreibung_de,
 'Reset to recommend. Price' AS beschreibung_cz,
 'Reset to recommend. Price' AS beschreibung_pl,
 'Reset to recommend. Price' AS beschreibung_sk,
 'vratiti na predloženu prodajnu cijenu' AS beschreibung_hr,
 'Reset to recommend. Price' AS beschreibung_ro,
 'Reset to recommend. Price' AS beschreibung_bg,
 'Reset to recommend. Price' AS beschreibung_en;