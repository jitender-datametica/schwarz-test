CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_marktbestand_art_1 (mandant_id, wup_id, nb_id, art_id,
dat, wrg_id, relevant_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, vk_netto_lgbest_erp_frei,
vk_netto_lgbest_erp_qual, vk_brutto_lgbest_erp_frei, vk_brutto_lgbest_erp_qual, menge_lgbest_erp_gesp_bme,
vk_netto_lgbest_gesp_frei, vk_brutto_lgbest_gesp_frei) AS SELECT V01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.art_id,
 V01.dat,
 krs.nach_wrg_id AS wrg_id,
 V01.relevant_fg,
 V01.menge_lgbest_erp_frei_bme,
 V01.menge_lgbest_erp_qual_bme,
 ROUND(CAST(V01.menge_lgbest_erp_frei_bme * V02.vk_netto * krs.umrechnungskurs AS BIGNUMERIC), 5) AS
 vk_netto_lgbest_erp_frei,
 ROUND(CAST(V01.menge_lgbest_erp_qual_bme * V02.vk_netto * krs.umrechnungskurs AS BIGNUMERIC), 5) AS
 vk_netto_lgbest_erp_qual,
 ROUND(CAST(V01.menge_lgbest_erp_frei_bme * V02.vk_netto * ((100 + M.mwst) / 100.00) * krs.umrechnungskurs AS BIGNUMERIC)
  , 5) AS vk_brutto_lgbest_erp_frei,
 ROUND(CAST(V01.menge_lgbest_erp_qual_bme * V02.vk_netto * ((100 + M.mwst) / 100.00) * krs.umrechnungskurs AS BIGNUMERIC)
  , 5) AS vk_brutto_lgbest_erp_qual,
 V01.menge_lgbest_erp_gesp_bme,
 ROUND(CAST(V01.menge_lgbest_erp_gesp_bme * V02.vk_netto * krs.umrechnungskurs AS BIGNUMERIC), 5) AS
 vk_netto_lgbest_gesp_frei,
 ROUND(CAST(V01.menge_lgbest_erp_gesp_bme * V02.vk_netto * ((100 + M.mwst) / 100.00) * krs.umrechnungskurs AS BIGNUMERIC)
  , 5) AS vk_brutto_lgbest_gesp_frei
FROM kfl_production_dbp_view.v_marktbestand_erp_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_marktbestand_erp_zu_1 AS V02 ON V01.bestand_id = V02.bestand_id AND V01.mandant_id =
   V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON V01.art_id = A.art_id AND V01.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS M ON A.mwst_id = M.mwst_id AND A.mandant_id = M.mandant_id AND V01.dat
   BETWEEN M.dat_von AND M.dat_bis
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V02.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;