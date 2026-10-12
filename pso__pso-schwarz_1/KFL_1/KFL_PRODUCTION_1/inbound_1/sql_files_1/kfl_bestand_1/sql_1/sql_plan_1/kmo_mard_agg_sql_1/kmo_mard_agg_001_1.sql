CREATE OR REPLACE TABLE DBP_ETL.lagerbestand_erp_wg_dat_1  
(  init_dat_von DATE NOT NULL) 
;

INSERT INTO DBP_ETL.lagerbestand_erp_wg_dat_1 (init_dat_von)
values ( CURRENT_DATE - 30)
;

DELETE FROM DBP_DATA.lagerbestand_erp_wg_1 lew
using DBP_ETL.lagerbestand_erp_wg_dat_1 led
WHERE lew.dat >= led.init_dat_von
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO  DBP_DATA.lagerbestand_erp_wg_1
(
  mandant_id
, wrg_id
, wup_id
, nb_id
, lagerort_id
, wg_id
, dat
, arthiertyp_id
, menge_lgbest_erp_frei_bme
, menge_lgbest_erp_umlag_bme
, menge_lgbest_erp_qual_bme
, menge_lgbest_erp_nf_charge_bme
, menge_lgbest_erp_gesp_bme
, menge_lgbest_erp_ret_gesp_bme
, menge_lgbest_erp_kolli
, menge_lgbest_erp_palette
, betrag_lgbest_erp
, vk_netto_lgbest_erp
, td_insert
, td_update
)
SELECT
   mard.mandant_id
  ,mard.wrg_id
  ,mard.wup_id
  ,mard.nb_id
  ,mard.lagerort_id
  ,awzp.wg_id
  ,dat.dat
  ,awzp.arthiertyp_id                       AS arthiertyp_id
  ,SUM(mard.menge_lgbest_erp_frei_bme)      AS menge_lgbest_erp_frei_bme
  ,SUM(mard.menge_lgbest_erp_umlag_bme)     AS menge_lgbest_erp_umlag_bme
  ,SUM(mard.menge_lgbest_erp_qual_bme)      AS menge_lgbest_erp_qual_bme
  ,SUM(mard.menge_lgbest_erp_nf_charge_bme) AS menge_lgbest_erp_nf_charge_bme
  ,SUM(mard.menge_lgbest_erp_gesp_bme)      AS menge_lgbest_erp_gesp_bme
  ,SUM(mard.menge_lgbest_erp_ret_gesp_bme)  AS menge_lgbest_erp_ret_gesp_bme
  ,SUM(mard.menge_lgbest_erp_kolli)         AS menge_lgbest_erp_kolli
  ,SUM(mard.menge_lgbest_erp_palette)       AS menge_lgbest_erp_palette
  ,SUM(CAST(mard.betrag_lgbest_erp AS DECIMAL(18,4))) AS betrag_lgbest_erp
  ,SUM(mard.vk_netto_lgbest_erp)            AS vk_netto_lgbest_erp
  ,CURRENT_TIMESTAMP
  ,CURRENT_TIMESTAMP
FROM DBP_DATA.lagerbestand_erp_per_1 mard_1

INNER JOIN DBP_DATA.art_wg_zu_per_1 awzp
  ON mard.art_id = awzp.art_id 
  AND awzp.arthiertyp_id = 2 
  AND mard.mandant_id = awzp.mandant_id
  AND awzp.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')

INNER JOIN
(  SELECT dat
   FROM DBP_DATA.tag_1,
       DBP_ETL.lagerbestand_erp_wg_dat_1 led  
   WHERE  dat BETWEEN init_dat_von AND CURRENT_DATE  
) dat
  ON dat.dat BETWEEN mard.dat_von AND mard.dat_bis

GROUP BY 1, 2, 3, 4, 5, 6, 7, 8 ,19,20
;

