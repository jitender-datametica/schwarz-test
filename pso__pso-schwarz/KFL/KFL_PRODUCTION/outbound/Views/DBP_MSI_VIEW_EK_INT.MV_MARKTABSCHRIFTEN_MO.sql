CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_marktabschriften_mo AS SELECT wup_id,
 nb_id,
 kjmo,
 mandant_id,
 abschriftart_id,
 art_id,
 abschriftbetrag_netto,
 abschriftbetrag_netto_vj,
 wrg_id,
 wup_bereinigt_fg
FROM kfl_production_dbp_msi_v_view.v_marktabschriften_coi_mo;