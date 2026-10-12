--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_wup_ek_zu_per_rb_kmo_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_wup_ek_zu_per_rb_kmo_2  (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      dat_von DATE NOT NULL,
      dat_bis DATE NOT NULL,
      ek_netto DECIMAL(18,4),
      ek_netto_bnk DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      komponentenmenge DECIMAL(9,4) NOT NULL DEFAULT 1.0000  ,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL DEFAULT 'EUR' ,
      ek_nettonetto DECIMAL(18,4),
      kein_zekp_fg BYTEINT NOT NULL )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_wup_ek_zu_per_rb_kmo_2 (art_id,
                                                mandant_id,
                                                wup_id,
                                                nb_id,
                                                dat_von,
                                                dat_bis,
                                                ek_netto,
                                                ek_netto_bnk,
                                                ek_mep,
                                                einstandspreis,
                                                komponentenmenge,
                                                wrg_id,
                                                ek_nettonetto,
                                                kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       dat_bis,
       ek_netto,
       ek_netto_bnk,
       ek_mep,
       einstandspreis,
       komponentenmenge,
       wrg_id,
       ek_nettonetto,
       kein_zekp_fg
FROM DBP_DATA.art_wup_ek_zu_per_2
WHERE mandant_id > 1;

