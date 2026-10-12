--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_tag_best_wg_wechsel_tmp_1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.vis_tag_best_wg_wechsel_tmp_1  (
    mandant_id       BYTEINT NOT NULL
   ,art_id           INTEGER NOT NULL
   ,arthiertyp_id    BYTEINT NOT NULL
   ,alt_neu_kz       BYTEINT NOT NULL
   ,wg_id            SMALLINT NOT NULL
   , UNIQUE (mandant_id, art_id, arthiertyp_id, alt_neu_kz)
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_tag_best_wg_wechsel_join_1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.vis_tag_best_wg_wechsel_join_1  (
    mandant_id       BYTEINT NOT NULL
   ,art_id           INTEGER NOT NULL
   ,arthiertyp_id    BYTEINT NOT NULL
   ,dat              DATE NOT NULL
   ,alt_neu_kz       BYTEINT NOT NULL
   ,wg_id            SMALLINT NOT NULL
--   ,mwst             DECIMAL(12,2) NOT NULL
   ,gj               SMALLINT NOT NULL
   ,kjmo             INTEGER NOT NULL
   ,kjwo             INTEGER NOT NULL
) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_tag_best_wg_wechsel_sum_t1_1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_tag_best_wg_wechsel_sum_t1_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      kjwo INTEGER NOT NULL,
      arthiertyp_id BYTEINT NOT NULL ,
      nb_id SMALLINT NOT NULL ,
      relevant_fg BYTEINT NOT NULL ,
      bezugsweg_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      anz_artikel_bestand INTEGER NOT NULL,
      anz_artikel_fehlmengen INTEGER NOT NULL ,
      anz_artikel_nullbestand INTEGER NOT NULL ,
      anz_artikel_minusbestand INTEGER NOT NULL ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      betrag_vk_netto_frei_bme DECIMAL(18,4) ,
      betrag_vk_netto_qual_bme DECIMAL(18,4) ,
      betrag_vk_brutto_frei_bme DECIMAL(18,4) ,
      betrag_vk_brutto_qual_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_ntto_frei_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_ntto_qual_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_btto_frei_bme DECIMAL(18,4) ,
      betrag_mo_anf_vk_btto_qual_bme DECIMAL(18,4) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_best_wg_wechsel_tmp_1
(
   mandant_id
  ,art_id
  ,arthiertyp_id
  ,alt_neu_kz
  ,wg_id
)
SELECT
   mandant_id
  ,art_id
  ,arthiertyp_id
  ,-1
  ,wg_id
FROM DBP_ETL.vis_tag_bestand_wg_wechsel_log_1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_tag_best_wg_wechsel_tmp_1
(
   mandant_id
  ,art_id
  ,arthiertyp_id
  ,alt_neu_kz
  ,wg_id
)
SELECT
   t01.mandant_id
  ,t01.art_id
  ,t01.arthiertyp_id
  ,1
  ,t01.wg_id
FROM DBP_DATA.art_wg_zu_per_1 t01
WHERE t01.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
  AND t01.arthiertyp_id = 2
;

