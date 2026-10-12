CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_planknoten_per AS SELECT mandant_id,
 plantyp_id,
 plangruppe_id,
 planknoten_id,
 planknotenzaehler_int,
 dat_von,
 dat_bis,
 co_leistungsart_arbeitsplan_id,
 arbeitsplan_menge,
 arbeitsplan_menge_einh_id
FROM kfl_production_dbp_data.in_planknoten_per;