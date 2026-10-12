CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kunde_vkorg_vw_zu AS SELECT mandant_id,
 flw_kunde_id,
 flw_verkaufsorganisation_id,
 flw_vw_id,
 versand_bedingung_id,
 dat_erfasst,
 loesch_fg,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kunde_vkorg_vw_zu;