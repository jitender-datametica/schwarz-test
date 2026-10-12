CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_art_2 (art_id, mandant_id, mwst_id, land_id, region_id, kl_art_id, dat_von
, dat_bis, loesch_id, mutter_wb_id, display_fg, posten_kz_sap) AS SELECT art_id,
 mandant_id,
 mwst_id,
 land_id,
 region_id,
 kl_art_id,
 dat_von,
 dat_bis,
 loesch_id,
 mutter_wb_id,
  CASE
  WHEN artikeltyp_id = 12
  THEN 'X'
  ELSE ' '
  END AS display_fg,
 posten_kz_sap
FROM kfl_nfmd_core.src_teradata_master_data_art_2 AS V02;