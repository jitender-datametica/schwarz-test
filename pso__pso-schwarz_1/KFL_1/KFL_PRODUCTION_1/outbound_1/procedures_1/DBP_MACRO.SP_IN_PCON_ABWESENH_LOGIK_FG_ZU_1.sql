CREATE OR REPLACE
  PROCEDURE
    dbp_macro.sp_in_pcon_abwesenh_logik_fg_zu(
      IN P_MANDANT_ID FLOAT64,
      IN P_ABWESENHEIT_ID STRING,
      IN P_KJMO_VON FLOAT64,
      IN P_LOGIK_KZ STRING,
      IN P_LANGZEIT_ABWESEND_FG FLOAT64,
      IN P_GRUND STRING)
      BEGIN
        DECLARE sql_stmt STRING;

DECLARE sql_commit STRING;
BEGIN TRANSACTION;
-- Bevor neuer Datensatz hinzugefuegt wird
-- Wird, falls es zu dieser ABWESENHEIT_ID & MANDANT_ID schon ein Eintrag vorhanden ist,
-- wird in diesem das Gueltig bis geaendert.
SET sql_stmt =
  '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  kjmo_bis = CAST(@P_KJMO_VON - 1 AS INTEGER) WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_bis = 999912 ''';

EXECUTE IMMEDIATE(sql_stmt) USING P_KJMO_VON AS P_KJMO_VON,
P_MANDANT_ID AS P_MANDANT_ID,
P_ABWESENHEIT_ID AS P_ABWESENHEIT_ID;

IF P_LOGIK_KZ
= 'Ausgrenzen'
  THEN
    BEGIN
-- neuer Datensatz hinzufuegen
SET
  sql_stmt
  = '''INSERT INTO dbp_data.pcon_abwesenh_logik_fg_zu_1 (mandant_id, abwesenheit_id, kjmo_bis, kjmo_von, logik_kz  , langzeit_abwesend_fg, pflege_fg, beschaeftigungs_verbot_fg, krankheit_unfall_fg, sonstige_abwesenheit_fg,  freigestellt_fg, mutterschutz_fg, elternzeit_fg) (SELECT CAST(@P_MANDANT_ID AS INTEGER) AS mandant_id,   @P_ABWESENHEIT_ID AS abwesenheit_id,   999912 AS kjmo_bis,   CAST(@P_KJMO_VON AS INTEGER) AS kjmo_von,   @P_LOGIK_KZ AS logik_kz,   0 AS langzeit_abwesend_fg,   0 AS pflege_fg,   0 AS beschaeftigungs_verbot_fg,   0 AS krankheit_unfall_fg,   0 AS sonstige_abwesenheit_fg,   0 AS freigestellt_fg,   0 AS mutterschutz_fg,   0 AS elternzeit_fg) ''';

EXECUTE IMMEDIATE(sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,
P_ABWESENHEIT_ID AS P_ABWESENHEIT_ID,
P_KJMO_VON AS P_KJMO_VON,
P_LOGIK_KZ AS P_LOGIK_KZ;

END;

ELSE
  BEGIN
-- neuer Datensatz hinzufuegen
SET
  sql_stmt
  = '''INSERT INTO dbp_data.pcon_abwesenh_logik_fg_zu_1 (mandant_id, abwesenheit_id, kjmo_bis, kjmo_von, logik_kz  , langzeit_abwesend_fg, pflege_fg, beschaeftigungs_verbot_fg, krankheit_unfall_fg, sonstige_abwesenheit_fg,  freigestellt_fg, mutterschutz_fg, elternzeit_fg) (SELECT CAST(@P_MANDANT_ID AS INTEGER) AS mandant_id,   @P_ABWESENHEIT_ID AS abwesenheit_id,   999912 AS kjmo_bis,   CAST(@P_KJMO_VON AS INTEGER) AS kjmo_von,   @P_LOGIK_KZ AS logik_kz,   CAST(@P_LANGZEIT_ABWESEND_FG AS INTEGER) AS langzeit_abwesend_fg,   0 AS pflege_fg,   0 AS beschaeftigungs_verbot_fg,   0 AS krankheit_unfall_fg,   0 AS sonstige_abwesenheit_fg,   0 AS freigestellt_fg,   0 AS mutterschutz_fg,   0 AS elternzeit_fg) ''';

EXECUTE IMMEDIATE(sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,
P_ABWESENHEIT_ID AS P_ABWESENHEIT_ID,
P_KJMO_VON AS P_KJMO_VON,
P_LOGIK_KZ AS P_LOGIK_KZ,
P_LANGZEIT_ABWESEND_FG AS P_LANGZEIT_ABWESEND_FG;

-- Pruefen welcher Grund angegeben wurden ist
SET sql_stmt = '';
-- if (P_GRUND = "Mutterschutz")

IF P_GRUND
= 'Mutterschutz'
  THEN
    BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  mutterschutz_fg = CAST("1" AS INTEGER) WHERE mandant_id = 1 AND abwesenheit_id = CAST(2 AS STRING) AND kjmo_bis = 999912 ''';

END;

ELSE
  BEGIN
    IF P_GRUND
  = 'Elternzeit'
    THEN
      BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  elternzeit_fg = CAST("1" AS INTEGER) WHERE mandant_id = 1 AND abwesenheit_id = CAST(2 AS STRING) AND kjmo_bis = 999912 ''';

END;

ELSE
  BEGIN
    IF P_GRUND
  = 'Pflege'
    THEN
      BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  pflege_fg = CAST("1" AS INTEGER) WHERE mandant_id = 1 AND abwesenheit_id = CAST(2 AS STRING) AND kjmo_bis = 999912 ''';

END;

ELSE
  BEGIN
    IF P_GRUND
  = 'Beschaeftigungsverbot'
    THEN
      BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  beschaeftigungs_verbot_fg = CAST("1" AS INTEGER) WHERE mandant_id = 1 AND abwesenheit_id = CAST(2 AS STRING) AND kjmo_bis = 999912 ''';

END;

ELSE
  BEGIN
    IF P_GRUND
  = 'Krankheit Unfall'
    THEN
      BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  krankheit_unfall_fg = CAST("1" AS INTEGER) WHERE mandant_id = 1 AND abwesenheit_id = CAST(2 AS STRING) AND kjmo_bis = 999912 ''';

END;

ELSE
  BEGIN
    IF P_GRUND
  = 'Sonstige'
    THEN
      BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  sonstige_abwesenheit_fg = CAST("1" AS INTEGER) WHERE mandant_id = 1 AND abwesenheit_id = CAST(2 AS STRING) AND kjmo_bis = 999912 ''';

END;

ELSE
  BEGIN
    IF P_GRUND
  = 'Freigestellt'
    THEN
      BEGIN
SET
  sql_stmt
  = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu_1 SET  freigestellt_fg = CAST("1" AS INTEGER) WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_bis = 999912 ''';

END;
END IF;

END;
END IF;

END;
END IF;

END;
END IF;

END;
END IF;

END;
END IF;

END;
END IF;

END;
END IF;

EXECUTE IMMEDIATE(sql_stmt) USING P_MANDANT_ID AS P_MANDANT_ID,
P_ABWESENHEIT_ID AS P_ABWESENHEIT_ID;

SET sql_commit = 'COMMIT TRANSACTION';

EXECUTE IMMEDIATE(sql_commit);

END;
