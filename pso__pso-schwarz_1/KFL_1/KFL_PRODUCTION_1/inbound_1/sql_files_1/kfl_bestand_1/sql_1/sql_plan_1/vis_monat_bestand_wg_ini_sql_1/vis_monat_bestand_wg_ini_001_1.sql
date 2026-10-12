--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_relevanz_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.vis_monat_bestand_relevanz_1  (
      mandant_id BYTEINT NOT NULL,
      kjmo_letzter_bestand INTEGER NOT NULL,
      kjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      gjmo INTEGER NOT NULL,
      max_dat DATE NOT NULL, UNIQUE ( mandant_id, kjmo ));

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_stamm_lkp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_monat_bestand_stamm_lkp_1  (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      max_dat DATE NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT,
      arthiertyp_id BYTEINT NOT NULL,
      mwst DECIMAL(12,2) NOT NULL,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_stamm_lkp2_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_monat_bestand_stamm_lkp2_1  (
      mandant_id BYTEINT NOT NULL ,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      kjmo INTEGER NOT NULL,
      art_id INTEGER NOT NULL,
      relevant_fg BYTEINT NOT NULL )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_tmp2_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_tmp2_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      art_id INTEGER NOT NULL,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      max_dat DATE NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT NOT NULL ,
      arthiertyp_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      mwst DECIMAL(12,2) NOT NULL)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_tmp3_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_tmp3_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      gjmo INTEGER NOT NULL,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT NOT NULL ,
      arthiertyp_id BYTEINT NOT NULL ,
      relevant_fg BYTEINT NOT NULL ,
      bezugsweg_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      betrag_vk_netto_frei_bme DECIMAL(18,4) ,
      betrag_vk_netto_qual_bme DECIMAL(18,4) ,
      betrag_vk_brutto_frei_bme DECIMAL(18,4) ,
      betrag_vk_brutto_qual_bme DECIMAL(18,4) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_monat_bestand_wg_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      gj SMALLINT NOT NULL,
      kjmo INTEGER NOT NULL,
      wg_id SMALLINT NOT NULL,
      abt_id SMALLINT NOT NULL ,
      arthiertyp_id BYTEINT NOT NULL ,
      relevant_fg BYTEINT NOT NULL ,
      bezugsweg_id BYTEINT NOT NULL ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      menge_lgbest_erp_frei_bme DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme DECIMAL(18,3) NOT NULL ,
      betrag_vk_netto_frei_bme DECIMAL(18,4) ,
      betrag_vk_netto_qual_bme DECIMAL(18,4) ,
      betrag_vk_brutto_frei_bme DECIMAL(18,4) ,
      betrag_vk_brutto_qual_bme DECIMAL(18,4) ,
      menge_lgbest_erp_frei_bme_kum DECIMAL(18,3) NOT NULL ,
      menge_lgbest_erp_qual_bme_kum DECIMAL(18,3) NOT NULL ,
      betrag_vk_netto_frei_bme_kum DECIMAL(18,4) ,
      betrag_vk_netto_qual_bme_kum DECIMAL(18,4) ,
      betrag_vk_brutto_frei_bme_kum DECIMAL(18,4) ,
      betrag_vk_brutto_qual_bme_kum DECIMAL(18,4) )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
INSERT INTO DBP_ETL.vis_monat_bestand_relevanz_1
(
   mandant_id
  ,kjmo_letzter_bestand
  ,kjmo
  ,gj
  ,gjmo
  ,max_dat
)
SELECT
   tmp.mandant_id
  ,tmp.kjmo_letzter_bestand
  ,m.kjmo
  ,m.gj
  ,m.gjmo
  ,CASE
   WHEN EXTRACT(MONTH FROM m.max_dat) = EXTRACT(MONTH FROM CURRENT_DATE)
   THEN CURRENT_DATE
   ELSE m.max_dat
 END AS max_dat
FROM
(
  SELECT
     mandant_id
    ,MAX(kjmo)    AS kjmo_letzter_bestand
  FROM DBP_MSI_DATA.vis_monat_bestand_wg_1
  GROUP BY 1
) tmp
  INNER JOIN
     DBP_DATA.monat_1 m
  ON  tmp.kjmo_letzter_bestand < m.kjmo
  AND m.akt_mo <= 0
;

