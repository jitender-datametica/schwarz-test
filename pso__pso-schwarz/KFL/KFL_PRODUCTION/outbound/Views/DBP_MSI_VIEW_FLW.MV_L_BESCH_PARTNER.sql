CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_besch_partner (faktura_beleg_id, mandant_id, in_kunde_id,
kunde_nr, kunde_name) AS SELECT V01.faktura_beleg_id,
 V01.mandant_id,
 V01.flw_kunde_id AS in_kunde_id,
 COALESCE(COLLATE(LTRIM(COLLATE(V02.kunde_nr, ''), '0'), 'und:ci'), 'kein Lookup vorhanden') AS kunde_nr,
 COALESCE(V02.kunde_name, 'kein Lookup vorhanden') AS kunde_name
FROM kfl_production_dbp_view.v_flw_besch_partner AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kunde AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_kunde_id = V02.flw_kunde_id
   
WHERE V01.partner_verwendung_id = 'WE';