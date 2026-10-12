CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abteilung_per AS SELECT mandant_id,
 abt_id,
 arthiertyp_id,
 kstabt_id,
 spr_id,
 dat_von,
 dat_bis,
 dat_extrakt,
 kstabt_bez
FROM kfl_production_dbp_data.abteilung_per;