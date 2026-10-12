CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ts_bestwertfortschreibung_2 (mandant_id, wup_id, nb_id, dat,
owg_id, arthiertyp_id, umsatz_plan_brutto_owg, wareneingang_brutto_owg, schlussbestand_vormonat_brutto_owg,
datzeit_pflege, wrg_id) AS SELECT BWF.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 BWF.nb_id,
 BWF.dat,
 BWF.owg_id,
 BWF.arthiertyp_id,
 BWF.umsatz_plan_brutto_owg,
 BWF.wareneingang_brutto_owg,
 BWF.schlussbestand_vormonat_brutto_owg,
 BWF.datzeit_pflege,
 BWF.wrg_id
FROM kfl_production_dbp_msi_v_view.v_ts_bestwertfortschreibung_2 AS BWF
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON BWF.mandant_id = WUP.mandant_id AND BWF.wup_id = WUP.wup_id;