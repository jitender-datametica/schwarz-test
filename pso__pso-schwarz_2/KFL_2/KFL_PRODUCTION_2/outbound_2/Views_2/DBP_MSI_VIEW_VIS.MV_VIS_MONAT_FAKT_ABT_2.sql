CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_abt_2 (mandant_id, nb_id, wup_id, wrg_id,
arthiertyp_id, abt_id, kjmo, gj, ums_netto, ums_netto_kvj, ums_netto_kvvj, ums_netto_plan) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.wrg_id,
 V01.arthiertyp_id,
 V01.abt_id,
 V01.kjmo,
 V01.gj,
 V01.ums_netto,
 V01.ums_netto_kvj,
 V01.ums_netto_kvvj,
 V01.ums_netto_plan
FROM kfl_production_dbp_msi_v_view.v_vis_monat_umsatz_abt_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;