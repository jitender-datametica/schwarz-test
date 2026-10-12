CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_akl_leistung AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 dat,
 stunde,
 lagertyp_id,
 meldepunkt,
 warenbewegungstyp_id,
 lager_einheiten_typ,
 menge_lbs_lvs_palette,
 menge_lbs_lvs_kolli
FROM kfl_production_dbp_view.v_akl_leistung;