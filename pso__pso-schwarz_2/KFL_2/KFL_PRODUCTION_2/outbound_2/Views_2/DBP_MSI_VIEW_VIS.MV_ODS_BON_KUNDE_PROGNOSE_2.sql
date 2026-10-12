CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_kunde_prognose_2 (mandant_id, wup_id, nb_id, dat,
zeit_stunde, zeit_minute, datzeit_prognose, anz_kunden, anz_kunden_prognose, anz_kunden_prognose_dyn, anz_kassen_offen,
anz_kassen_prognose, anz_kassen_prognose_dyn, datzeit_update) AS SELECT BKP.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 BKP.nb_id,
 BKP.dat,
 BKP.zeit_stunde,
 BKP.zeit_minute,
     CAST(BKP.dat AS STRING) || ' ' || TRIM(CAST(BKP.zeit_stunde AS STRING FORMAT '00')) || CAST(BKP.zeit_minute AS STRING FORMAT ':99')
    || ':00' AS datzeit_prognose,
 BKP.anz_kunden,
 BKP.anz_kunden_prognose,
 BKP.anz_kunden_prognose_dyn,
 BKP.anz_kassen_offen,
 BKP.anz_kassen_prognose,
 BKP.anz_kassen_prognose_dyn,
 BKP.datzeit_update
FROM kfl_production_dbp_v_ods.v_ods_bon_kunde_prognose_2 AS BKP
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON BKP.mandant_id = WUP.mandant_id AND BKP.wup_id = WUP.wup_id;