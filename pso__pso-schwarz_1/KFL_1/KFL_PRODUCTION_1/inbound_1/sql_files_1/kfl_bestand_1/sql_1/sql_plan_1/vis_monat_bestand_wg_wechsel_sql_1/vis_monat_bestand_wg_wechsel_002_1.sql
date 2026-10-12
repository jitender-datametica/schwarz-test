--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_mard_relevant_1  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      dat DATE NOT NULL,
      art_id INTEGER NOT NULL,
      bezugsweg_id BYTEINT ,
      relevant_fg BYTEINT NOT NULL DEFAULT 1  )
;

