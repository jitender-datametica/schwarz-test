CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_abschriften_wg_1 (mandant_id, nb_id, wup_id, wrg_id,
arthiertyp_id, abt_id, wg_id, abschriftgruppe_id, kjmo, gj, abschrift_brutto, abschrift_brutto_kum, abschrift_brutto_kvj
, abschrift_brutto_kvj_kum) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.wrg_id,
 V01.arthiertyp_id,
 V01.abt_id,
 V01.wg_id,
 V01.abschriftgruppe_id,
 V01.kjmo,
 V01.gj,
 V01.abschrift_brutto,
 V01.abschrift_brutto_kum,
 V01.abschrift_brutto_kvj,
 V01.abschrift_brutto_kvj_kum
FROM kfl_production_dbp_msi_v_view.v_vis_monat_abschriften_wg_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;