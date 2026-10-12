CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_faktura_kmo_columnar AS SELECT mandant_id,
 faktura_beleg_id,
 fakturaart_id,
 dat_faktura_sap,
 fktyp,
 kurrf,
 dat_erstellung,
 zeit_erstellung,
 wrg_id,
 beleg_kondition_id,
 mandant_id_empfaenger
FROM kfl_production_dbp_data.besch_faktura_kmo_columnar;