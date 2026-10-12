CREATE OR REPLACE PROCEDURE dbp_macro.sp_up_pcon_abwesenh_logik_fg_zu(
  IN P_MANDANT_ID FLOAT64, 
  IN P_ABWESENHEIT_ID STRING, 
  IN P_KJMO_BIS FLOAT64, 
  IN P_KJMO_VON FLOAT64, 
  IN P_LOGIK_KZ STRING, 
  IN P_LANGZEIT_ABWESEND_FG FLOAT64, 
  IN P_GRUND STRING,
  IN P_ALT_KJMO_VON FLOAT64
)
BEGIN
  DECLARE sql_stmt STRING;
  DECLARE sql_commit STRING;

  BEGIN TRANSACTION;

  --Vorhandener Datensatz aendern.
  IF P_LOGIK_KZ = 'Ausgrenzen' THEN
  SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = 0,     pflege_fg = 0, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 0, freigestellt_fg = 0, mutterschutz_fg = 0, elternzeit_fg = 0  WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID  AND kjmo_von = @P_ALT_KJMO_VON''';

    EXECUTE IMMEDIATE (sql_stmt) USING P_KJMO_BIS AS P_KJMO_BIS,P_KJMO_VON AS P_KJMO_VON, P_LOGIK_KZ AS P_LOGIK_KZ, P_MANDANT_ID AS P_MANDANT_ID, P_ABWESENHEIT_ID AS P_ABWESENHEIT_ID, P_ALT_KJMO_VON AS P_ALT_KJMO_VON;

  -- Fallunterscheidung Grund 
  ELSE
    CASE P_GRUND
      WHEN 'Mutterschutz' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 0, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 0, freigestellt_fg = 0, mutterschutz_fg = 1, elternzeit_fg = 0 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      WHEN 'Elternzeit' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 0, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 0, freigestellt_fg = 0, mutterschutz_fg = 0, elternzeit_fg = 1 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      WHEN 'Pflege' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 1, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 0, freigestellt_fg = 0, mutterschutz_fg = 0, elternzeit_fg = 0 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      WHEN 'Beschaeftigungsverbot' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 0, beschaeftigungs_verbot_fg = 1, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 0, freigestellt_fg = 0, mutterschutz_fg = 0, elternzeit_fg = 0 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      WHEN 'Krankheit Unfall' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 0, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 1, sonstige_abwesenheit_fg = 0, freigestellt_fg = 0, mutterschutz_fg = 0, elternzeit_fg = 0 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      WHEN 'Sonstige' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 0, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 1, freigestellt_fg = 0, mutterschutz_fg = 0, elternzeit_fg = 0 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      WHEN 'Freigestellt' THEN
        SET sql_stmt = '''UPDATE dbp_data.pcon_abwesenh_logik_fg_zu SET kjmo_bis = CAST(@P_KJMO_BIS AS INT64), kjmo_von = CAST(@P_KJMO_VON AS INT64), logik_kz = @P_LOGIK_KZ, langzeit_abwesend_fg = CAST(@P_LANGZEIT_ABWESEND_FG AS INT64), pflege_fg = 0, beschaeftigungs_verbot_fg = 0, krankheit_unfall_fg = 0, sonstige_abwesenheit_fg = 0, freigestellt_fg = 1, mutterschutz_fg = 0, elternzeit_fg = 0 WHERE mandant_id = @P_MANDANT_ID AND abwesenheit_id = @P_ABWESENHEIT_ID AND kjmo_von = @P_ALT_KJMO_VON''';
      ELSE
        SET sql_stmt = NULL;
    END CASE;

    IF sql_stmt IS NOT NULL THEN
      EXECUTE IMMEDIATE (sql_stmt) USING 
        P_KJMO_BIS AS P_KJMO_BIS,
        P_KJMO_VON AS P_KJMO_VON,
        P_LOGIK_KZ AS P_LOGIK_KZ,
        P_LANGZEIT_ABWESEND_FG AS P_LANGZEIT_ABWESEND_FG,
        P_MANDANT_ID AS P_MANDANT_ID,
        P_ABWESENHEIT_ID AS P_ABWESENHEIT_ID,
        P_ALT_KJMO_VON AS P_ALT_KJMO_VON;
    END IF;

  END IF;

  SET sql_commit = 'COMMIT TRANSACTION';
  EXECUTE IMMEDIATE (sql_commit);

END;


