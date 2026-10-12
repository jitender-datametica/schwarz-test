CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_artb_ku_monat_wg_wup_sum_1 AS SELECT mandant_id,
 nb_id,
 wup_id,
 wrg_id AS umsatz_wrg,
 arthiertyp_id,
 wg_id,
 kjmo,
 ums_netto AS umsatz_netto,
 ums_netto_kvj AS umsatz_netto_vj,
 ums_netto_kvvj AS umsatz_netto_vvj
FROM kfl_production_dbp_msi_v_view.v_vis_monat_umsatz_wg_1 AS V01;