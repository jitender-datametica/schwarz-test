CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_virtuell_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 lagernummer_id,
 bsflaeche_id,
 doppelbelegung_fg,
 dat_von,
 dat_bis,
 bsf_virtuell_fg
FROM kfl_production_dbp_data.wup_lagernummer_bsflaeche_virtuell_per;