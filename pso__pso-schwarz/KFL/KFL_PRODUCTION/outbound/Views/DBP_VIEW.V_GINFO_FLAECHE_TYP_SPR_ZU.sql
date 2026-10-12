CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu AS SELECT ginfo_flaeche_typ_id,
 mandant_id,
 spr_id,
 flaeche_quelle_id,
 ginfo_flaeche_typ_bez
FROM kfl_production_dbp_data.ginfo_flaeche_typ_spr_zu;