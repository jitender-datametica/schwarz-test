CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbe_typ AS SELECT mandant_id,
 werbe_typ_id,
 wtag_id_start,
 wtag_id_ende
FROM kfl_production_dbp_data.l_werbe_typ;