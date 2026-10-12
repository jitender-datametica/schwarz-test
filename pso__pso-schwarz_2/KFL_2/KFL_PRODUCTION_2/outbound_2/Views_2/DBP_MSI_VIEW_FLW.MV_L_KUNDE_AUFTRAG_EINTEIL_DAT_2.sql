CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_kunde_auftrag_einteil_dat_2 (mandant_id, verkaufs_beleg_id,
verkaufs_beleg_pos_id, einteil_id, dat_einteilung, zeit_einteilung) AS SELECT mandant_id,
 verkaufs_beleg_id,
 verkaufs_beleg_pos_id,
 einteil_id,
 dat_einteilung,
 zeit_einteilung
FROM kfl_production_dbp_view.v_flw_kunde_auftrag_einteil_2 AS V01
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), verkaufs_beleg_id, CAST(verkaufs_beleg_pos_id AS STRING)
      ORDER BY einteil_id IS NULL, einteil_id)) = 1;