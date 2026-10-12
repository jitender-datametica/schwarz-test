--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_LOAD.faktura_medata_rb_1 WHERE ek_netto_bnk_neu IS NULL;
--
--Comment from validation checker
--error line 1 at position 63
--DELETE FROM DBP_ETL.faktura_medata_rb_1 WHERE ek_netto_bnk_neu IS ^^^>  NULL;
--invalid identifier 'EK_NETTO_BNK_NEU'
--translated statement
DELETE FROM DBP_ETL.faktura_medata_rb_1 WHERE ek_netto_bnk_neu IS NULL;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_LOAD.faktura_medata_rb_1 WHERE ek_mep_neu IS NULL;
--
--Comment from validation checker
--error line 1 at position 63
--DELETE FROM DBP_ETL.faktura_medata_rb_1 WHERE ek_mep_neu IS NULL; ^^^> 
--invalid identifier 'EK_MEP_NEU'
--translated statement
DELETE FROM DBP_ETL.faktura_medata_rb_1 WHERE ek_mep_neu IS NULL;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_LOAD.faktura_medata_rb_1 WHERE logistikkostenzuschlag_neu IS NULL;
--
--Comment from validation checker
--error line 1 at position 63
--DELETE FROM DBP_ETL.faktura_medata_rb_1 WHERE logistikkostenzusch ^^^> lag_neu IS NULL;
--invalid identifier 'LOGISTIKKOSTENZUSCHLAG_NEU'
--translated statement
DELETE FROM DBP_ETL.faktura_medata_rb_1 WHERE logistikkostenzuschlag_neu IS NULL;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.besch_faktura_medata_1
       WHERE    (art_id
                , mandant_id
                , faktura_markt
                , dat_faktura
                , wup_id
                , nb_id)
       IN 
       (
        SELECT  
             art_id
             , mandant_id
             , faktura_markt
             , dat_faktura
             , wup_id
             , nb_id 
        FROM DBP_ETL.faktura_medata_rb_1
        )
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.besch_faktura_medata_1
--
--(
-- art_id
-- ,mandant_id
-- ,faktura_markt
-- ,dat_faktura
-- ,wup_id
-- ,nb_id
-- ,zwsum_3_betrag
-- ,menge_fakturiert
-- ,ek_netto_bnk
-- ,ek_mep
-- ,logistikkostenzuschlag
--)
--
--SELECT 
--
--  t0.art_id
-- ,t0.mandant_id
-- ,t0.faktura_markt
-- ,t0.dat_faktura
-- ,t0.wup_id
-- ,t0.nb_id
-- ,t0.zwsum_3_betrag
-- ,t0.menge_fakturiert
-- ,t0.ek_netto_bnk_neu           AS ek_netto_bnk
-- ,t0.ek_mep_neu                 AS ek_mep
-- ,t0.logistikkostenzuschlag_neu AS logistikkostenzuschlag
--	
--FROM
--	DBX_LOAD.faktura_medata_rb_1 t0
--;
--
--Comment from validation checker
--error line 27 at position 2
-- , ^^^> t0.ek_netto_bnk_neu           AS ek_netto_bnk
--invalid identifier 'T0.EK_NETTO_BNK_NEU'
--translated statement
INSERT INTO DBP_DATA.besch_faktura_medata_1

(
 art_id
 ,mandant_id
 ,faktura_markt
 ,dat_faktura
 ,wup_id
 ,nb_id
 ,zwsum_3_betrag
 ,menge_fakturiert
 ,ek_netto_bnk
 ,ek_mep
 ,logistikkostenzuschlag
)

SELECT 

  t0.art_id
 ,t0.mandant_id
 ,t0.faktura_markt
 ,t0.dat_faktura
 ,t0.wup_id
 ,t0.nb_id
 ,t0.zwsum_3_betrag
 ,t0.menge_fakturiert
 ,t0.ek_netto_bnk_neu           AS ek_netto_bnk
 ,t0.ek_mep_neu                 AS ek_mep
 ,t0.logistikkostenzuschlag_neu AS logistikkostenzuschlag
	
FROM
	DBP_ETL.faktura_medata_rb_1 t0
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_MEDATA_DATE_1' does not exist or not authorized.
UPDATE DBP_ETL.rb_faktura_medata_date_1
SET rb_status=1
WHERE dat_von = CAST((SELECT dat_von FROM DBP_ETL.rb_faktura_date_metadata_min_1 ) AS DATE) 
AND dat_bis = CAST((SELECT dat_bis FROM DBP_ETL.rb_faktura_date_metadata_max_1 ) AS DATE)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.rb_faktura_date_metadata_min_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.rb_faktura_date_metadata_max_1;

