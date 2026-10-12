CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_in_lieferant AS SELECT in_lief_id,
 mandant_id,
 LTRIM(COLLATE(in_lief_nr, ''), '0') AS in_lief_nr,
   lief_name_1 || ' ' || lief_name_2 AS lief_name
FROM kfl_production_dbp_view.v_in_lieferant;