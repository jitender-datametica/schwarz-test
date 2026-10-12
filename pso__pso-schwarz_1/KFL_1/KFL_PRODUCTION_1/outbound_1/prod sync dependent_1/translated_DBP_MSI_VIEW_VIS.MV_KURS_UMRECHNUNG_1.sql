/* 2025-07-25 tekin: Erstellung der Lookup-View zur Waehrungsumrechnung */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_1 (von_wrg_id, nach_wrg_id, umrechnungskurs) AS
SELECT von_wrg_id,
 nach_wrg_id,
 umrechnungskurs
FROM kfl_production_dbp_data.kurs_1 AS KRS1
WHERE kurstyp_id = 3
 AND dat_bis = DATE '9999-12-31'
 AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
UNION ALL
SELECT von_wrg_id,
 von_wrg_id AS von_wrg_id0,
 1.0000
FROM kfl_production_dbp_data.kurs_1 AS KRS2
WHERE kurstyp_id = 3
 AND dat_bis = DATE '9999-12-31'
 AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR');