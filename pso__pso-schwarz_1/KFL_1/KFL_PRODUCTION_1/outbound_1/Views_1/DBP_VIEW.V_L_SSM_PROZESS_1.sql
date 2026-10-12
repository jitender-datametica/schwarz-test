CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ssm_prozess_1 AS SELECT mandant_id,
 ssm_prozess_id,
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
 rundung_typ_kz
FROM kfl_production_dbp_data.l_ssm_prozess_1;