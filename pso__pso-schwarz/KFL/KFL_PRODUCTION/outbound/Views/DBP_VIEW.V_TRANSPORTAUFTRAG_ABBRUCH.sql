CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportauftrag_abbruch AS SELECT transport_beleg_id,
 mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 abbr_pos_id,
 dat_abbr,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_abbr AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_abbr,
 ebene_wechsel_fg
FROM kfl_production_dbp_data.transportauftrag_abbruch;