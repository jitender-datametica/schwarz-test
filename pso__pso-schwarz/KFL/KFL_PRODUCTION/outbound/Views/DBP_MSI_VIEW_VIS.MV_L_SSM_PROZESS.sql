CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ssm_prozess AS SELECT ssm_prozess_id,
 ssm_aufwand_typ_id,
 wup_abt_id,
 treiber_id,
 dat_von,
 dat_bis,
 ssm_prozess_bez,
 dayforce_xrefcode,
 dayforce_xrefcode_de,
 dayforce_minimal_mapping,
 oeffnung_laden_theken_fg,
 rundung_typ_kz,
 mandant_id
FROM kfl_production_dbp_view.v_l_ssm_prozess;