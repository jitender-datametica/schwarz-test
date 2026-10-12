CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_marktabschriften_coi_dat_2 AS SELECT wup_id,
 nb_id,
 dat,
 mandant_id,
 abschriftart_id,
 art_id,
 abschriftbetrag_netto,
 abschriftbetrag_netto_vj,
 wrg_id,
 wup_bereinigt_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_msi_data.marktabschriften_coi_dat_2;