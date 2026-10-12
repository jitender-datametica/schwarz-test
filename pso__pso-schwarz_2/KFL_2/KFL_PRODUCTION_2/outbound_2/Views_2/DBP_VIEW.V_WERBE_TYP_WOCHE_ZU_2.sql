CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbe_typ_woche_zu_2 AS SELECT mandant_id,
 werbe_typ_id,
 kjwo,
 werbewoche,
 kjmo
FROM kfl_production_dbp_data.werbe_typ_woche_zu_2;