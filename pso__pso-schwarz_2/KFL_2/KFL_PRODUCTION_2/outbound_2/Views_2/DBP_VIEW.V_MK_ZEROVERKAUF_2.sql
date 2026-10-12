CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mk_zeroverkauf_2 AS SELECT wup_id,
 nb_id,
 mandant_id,
 art_id,
 dat,
 zeitfenster_id,
 aktion_fg,
 art_fehlgrund_id,
 menge_lgbest,
 datzeit_letzter_abverkauf,
 art_fehlgrund_text,
 dat_erfasst,
 melde_fg
FROM kfl_production_dbp_data.mk_zeroverkauf_2;