CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_mis_lieferquote_2 (mandant_id, lieferquote_def, datenquote_def)
AS SELECT mandant_id,
 lieferquote AS lieferquote_def,
 datenquote AS datenquote_def
FROM kfl_production_dbp_msi_v_view.v_mis_lieferquote_2 AS V01;