CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktabschriften_kmo_aktion_2 AS SELECT wup_id,
 nb_id,
 aktion_id,
 mandant_id,
 dat,
 art_id,
 menge_abschrift,
 abschriftbetrag_netto,
 abschriftbetrag_brutto,
 wrg_id,
 vk_aktion_netto,
 vk_vor_aktion_netto,
 aktion_relevant_fg
FROM kfl_production_dbp_data.marktabschriften_kmo_aktion_2;