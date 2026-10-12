CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ginfo_flaeche_spr_zu_2 AS SELECT mandant_id,
 spr_id,
 ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 techn_platz_id,
 flaeche_quelle_id,
 ginfo_flaeche_bez
FROM kfl_production_dbp_data.ginfo_flaeche_spr_zu_2;