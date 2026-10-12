CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_faktura_kmo_1 AS SELECT mandant_id,
 faktura_beleg_id,
 fakturaart_id,
 dat_faktura_sap,
 fktyp,
 kurrf,
 dat_erstellung,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_erstellung AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_erstellung,
 wrg_id,
 beleg_kondition_id,
 mandant_id_empfaenger,
 td_update,
 td_insert
FROM kfl_production_dbp_data.besch_faktura_kmo_1;