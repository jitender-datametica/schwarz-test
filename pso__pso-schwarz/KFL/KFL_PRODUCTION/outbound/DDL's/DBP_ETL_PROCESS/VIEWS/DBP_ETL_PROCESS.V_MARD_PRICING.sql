CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_mard_pricing (mandant_id, dat, wup_id, nb_id, art_id,
menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_gesp_bme) AS SELECT A.mandant_id,
 A.dat,
 A.wup_id,
 A.nb_id,
 A.art_id,
 A.menge_lgbest_erp_frei_bme,
 A.menge_lgbest_erp_qual_bme,
 A.menge_lgbest_erp_gesp_bme
FROM kfl_production_dbp_data.marktbestand_erp AS A
 INNER JOIN kfl_production_dbp_data.art_wg_zu_per AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
     = 2 AND B.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_data.wg_spr_zu AS C ON A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND B.arthiertyp_id
     = C.arthiertyp_id AND C.spr_id = 22
 INNER JOIN kfl_production_dbp_data.wg_per AS D ON A.mandant_id = D.mandant_id AND B.wg_id = D.wg_id AND B.arthiertyp_id
     = D.arthiertyp_id AND D.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id AND E.nb_id = 0
WHERE D.owg_id IN (1006)
 AND A.mandant_id = 1
 AND A.nb_id = 0;