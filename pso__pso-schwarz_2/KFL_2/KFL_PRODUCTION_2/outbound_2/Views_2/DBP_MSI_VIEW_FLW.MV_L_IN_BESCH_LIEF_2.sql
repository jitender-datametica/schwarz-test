CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_besch_lief_2 (lief_beleg_id, mandant_id, werk_id,
in_kunde_id, kunde_nr, kunde_name, lief_typ_id, dat_beleg, dat_erfasst, dat_lief_soll, in_verkaufsorganisation_id) AS
SELECT V01.lief_beleg_id,
 V01.mandant_id,
 V01.werk_id,
 V01.flw_kunde_id AS in_kunde_id,
 COALESCE(COLLATE(LTRIM(COLLATE(V02.kunde_nr, ''), '0'), 'und:ci'), 'nicht in Lookup') AS kunde_nr,
 COALESCE(V02.kunde_name, 'nicht in Lookup') AS kunde_name,
 V01.lief_typ_id,
 V01.dat_beleg,
 V01.dat_erfasst,
 V01.dat_lief_soll,
 V01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id
FROM kfl_production_dbp_view.v_flw_besch_lief_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_kunde_id = V02.flw_kunde_id;