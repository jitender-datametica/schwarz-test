CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktabschriften_wg_sum AS SELECT mandant_id,
 wup_id,
 nb_id,
 abschriftart_id,
 wg_id,
 arthiertyp_id,
 dat,
 abschriftbetrag_netto,
 abschriftbetrag_brutto,
 wrg_id
FROM kfl_production_dbp_data.marktabschriften_wg_sum;