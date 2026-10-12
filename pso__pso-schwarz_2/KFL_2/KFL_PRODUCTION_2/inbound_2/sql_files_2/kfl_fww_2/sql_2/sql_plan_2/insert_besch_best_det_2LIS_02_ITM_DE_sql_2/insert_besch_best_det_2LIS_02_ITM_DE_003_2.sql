--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.besch_best_LBS_2  (
         mandant_id BYTEINT NOT NULL,
         best_beleg_id DECIMAL(18,0) NOT NULL,
         best_beleg_pos_id INTEGER NOT NULL,
         art_id INTEGER NOT NULL,
         wup_id INTEGER NOT NULL,
         nb_id SMALLINT NOT NULL,
         lagerort_id CHAR(4) COLLATE 'en-ci',
         menge_best_bme DECIMAL(18,3) NOT NULL,
         endlief_fg BYTEINT NOT NULL ,
         dat_best_beleg DATE NOT NULL,
         wrg_id CHAR(3) COLLATE 'en-ci',
         ek_netto DECIMAL(18,4), /*decimal 18,4*/
         betrag_best_ekn DECIMAL(18,4),
         gp_id INTEGER NOT NULL,
         bestellart_id CHAR(4) COLLATE 'en-ci' NOT NULL,
         komponentenmenge  DECIMAL(18,4),
         menge_best_kolli DECIMAL(18,3),
         loesch_fg BYTEINT,
         selbstabhol_fg BYTEINT
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON TABLE DBX_LOAD.besch_best_LBS_2 IS 'Arbeitstabelle fuer lvs_aktion - bsch_lief_LBS, bitte nicht loeschen';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON TABLE DB ^^^> P_ETL.besch_best_LBS_2 IS 'Arbeitstabelle fuer lvs_aktion - bsch_lief_LBS, bitte nicht loeschen';
--translated statement
COMMENT ON TABLE DBP_ETL.besch_best_LBS_2 IS 'Arbeitstabelle fuer lvs_aktion - bsch_lief_LBS, bitte nicht loeschen';

