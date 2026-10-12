CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mgg_abteilung_spr_zu_2 AS SELECT mandant_id,
 mgg_abteilung_id,
 spr_id,
 mgg_abteilung_bez
FROM kfl_production_dbp_data.mgg_abteilung_spr_zu_2;