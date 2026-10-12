CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_schicht AS SELECT mandant_id,
 schicht_id,
 schichttyp_id,
 datzeit_schicht_anfang,
 datzeit_schicht_ende,
 zeit_schicht_beginn,
 zeit_schicht_ende,
 flw_werk_id,
 flw_arbeitsplatz_id,
 dat_schicht,
 schicht_dauer,
 schicht_dauer_einh
FROM kfl_production_dbp_data.flw_mes_schicht;