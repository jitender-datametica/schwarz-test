CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_hier_eb_fkt_wup_zu_per_1 AS SELECT mandant_id,
 ma_hierarchie_typ_id,
 ma_hierarchie_id,
 dat_von,
 ma_funktion_id,
 ma_hierarchie_ebene_id,
 wup_id
FROM kfl_production_dbp_data.ma_hier_eb_fkt_wup_zu_per_1;