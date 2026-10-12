CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_WBS_ARTIKEL_VZ_MASSENBEARBEITUNG(
    "P_MANDANT_ID" FLOAT,
    "P_KJWO" VARCHAR,
    "P_ART_IDS" VARCHAR,
    "P_GPS" VARCHAR,
    -- "P_AUSLIEFERGRUPPEN" VARCHAR,
    "P_ANGEBOTE" VARCHAR,
    "P_CLEAR_STOCK_FG" FLOAT,
    "P_ADJUSTMENT_FG" FLOAT,
    "P_MAX_KAPA_FG" FLOAT,
    "P_ESTIMATION_FG" FLOAT,
    "P_DAT_LETZTE_NACHVERSORGUNG" DATE,
    "P_DATE_CLEAR" BOOLEAN,
    "P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ" FLOAT,
    "P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ" FLOAT
)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
COMMENT = 'Massenbearbeitung auf Artikelebene WBS'
AS
$$
DECLARE
    dummy_1 FLOAT;
BEGIN

    ------ STEP 1 UPDATE ------

    IF (:P_CLEAR_STOCK_FG IS NOT NULL) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET CLEAR_STOCK_ID = :P_CLEAR_STOCK_FG,
            TD_UPDATE      = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              HAVING LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_MAX_KAPA_FG IS NOT NULL) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET MAX_KAPA_FG = :P_MAX_KAPA_FG,
            TD_UPDATE   = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              HAVING LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_ADJUSTMENT_FG IS NOT NULL) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET ADJUSTMENT_ID = :P_ADJUSTMENT_FG,
            TD_UPDATE     = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              WHERE LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_DAT_LETZTE_NACHVERSORGUNG IS NOT NULL) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET DAT_LETZTE_NACHVERSORGUNG = :P_DAT_LETZTE_NACHVERSORGUNG,
            TD_UPDATE                 = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              HAVING LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_DAT_LETZTE_NACHVERSORGUNG IS NOT NULL AND :P_DATE_CLEAR = 0) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET DAT_LETZTE_NACHVERSORGUNG = :P_DAT_LETZTE_NACHVERSORGUNG,
            TD_UPDATE                 = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              HAVING LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_DATE_CLEAR = 1) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET DAT_LETZTE_NACHVERSORGUNG = NULL,
            TD_UPDATE                 = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              WHERE LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ IS NOT NULL) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ = :P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
            TD_UPDATE                                      = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              HAVING LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    IF (:P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ IS NOT NULL) THEN
        UPDATE DBP_DATA.ts_wbs_artikel_vz_1
        SET NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ = :P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ,
            TD_UPDATE                                      = CURRENT_TIMESTAMP
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
              HAVING LENGTH(table1.value) > 1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          );
    END IF;

    ------ STEP 2 INSERT ------

    INSERT INTO DBP_DATA.ts_wbs_artikel_vz_1 (
        mandant_id, kjwo, angebot_nr, aktion_id, ausliefergruppe_id, art_id,
        wup_id_vz, nb_id_vz, mandant_id_vz, bezugsweg_id, gp_id, clear_stock_id,
        lieferung_tag_offset, estimation_fg, max_kapa_fg, adjustment_id,
        dat_letzte_nachversorgung,
        nachversorgung_schwellwert_pal_abrundung_proz,
        nachversorgung_schwellwert_pal_aufrundung_proz,
        td_update, td_insert
    )
    WITH Art_UPDATE AS (
        SELECT *
        FROM DBP_DATA.ts_wbs_artikel_vz_1
        WHERE MANDANT_ID = :P_MANDANT_ID
          AND KJWO IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
          )
          AND ART_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
          )
          AND GP_ID IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
          )
          AND ANGEBOT_NR IN (
              SELECT TRIM(table1.value)
              FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
          )
    ),
    Angebot_Artikel AS (
        SELECT DISTINCT
            aw.mandant_id,
            agw.mandant_id AS mandant_id_vz,
            CASE WHEN LENGTH(TO_VARCHAR(ABS(agw.gp_id))) <= 4 THEN agw.gp_id ELSE -9 END AS wup_id_vz,
            CASE WHEN agw.auslieferungsgruppe_id = 'VEN' THEN a_gp.gp_id ELSE agw.gp_id END AS gp_id,
            -111 AS nb_id_vz,
            agw.auslieferungsgruppe_id AS ausliefergruppe_id,
            t.kjwo AS kjwo,
            ww.kjwo_ww,
            COALESCE(CASE WHEN aw.ANGEBOT_NR = '' THEN NULL ELSE aw.ANGEBOT_NR END, 'n/a') AS angebot_id,
            COALESCE(CASE WHEN a.aktion_id = '' THEN NULL ELSE a.aktion_id END, 'n/a') AS AKTION_ID,
            a.AKTION_TYP_ID AS BONUSKAUF_PROMOTIONSTYP,
            aw.art_id,
            a.dat_angebot_gueltig_von AS dat_von,
            a.dat_angebot_gueltig_bis AS dat_bis,
            DATEDIFF(DAY, a.dat_angebot_gueltig_von, a.dat_angebot_gueltig_bis) + 1 AS anz_tage_werbung
        FROM DBP_DATA.ANGEBOT_ART_WUP_ZU_1 AW
        JOIN DBP_DATA.ANGEBOT_1 A
          ON AW.ANGEBOT_NR = A.ANGEBOT_NR
         AND AW.mandant_id = A.mandant_id
         AND A.angebot_geloescht_fg = 0
        JOIN dbp_view.v_werbewoche_kl_1 ww
          ON A.mandant_id = ww.mandant_id
         AND A.dat_angebot_gueltig_von = ww.dat
        JOIN dbp_view.v_tag_1 t
         ON a.dat_angebot_gueltig_von = t.dat
        JOIN dbp_view.v_ART_GP_WUP_DTS_ZU_PER_1 agw
ON CASE WHEN aw.mandant_id = 4 THEN 7 ELSE aw.mandant_id END = agw.mandant_id
AND aw.art_id = agw.art_id
AND aw.wup_id = agw.wup_id
AND aw.nb_id = COALESCE(agw.nb_id, 0)
AND agw.dat_bis='9999-12-31'

LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 a_gp
ON aw.art_id = a_gp.art_id
AND aw.mandant_id = a_gp.mandant_id
AND aw.wup_id = a_gp.wup_id
AND aw.nb_id = a_gp.nb_id
AND a_gp.dat_bis='9999-12-31'
        WHERE aw.art_id NOT IN (0, -1)
          AND loesch_fg = 0
          AND EXISTS (
              SELECT 1
              FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_1 V02
              WHERE CURRENT_DATE - 1 BETWEEN V02.DAT_VON-7 AND V02.DAT_BIS
                AND AW.MANDANT_ID = V02.MANDANT_ID
                AND AW.WUP_ID     = V02.WUP_ID
                AND AW.ART_ID     = V02.ART_ID
          )
         AND angebot_status_id IN (4,6) 
         AND transfer_status_id IN (0,3,5,6) 
          AND angebot_geloescht_fg IN (0)
          AND CASE
                  WHEN AW.mandant_id = 7 AND angebot_typ_cd NOT IN ('ZAI','ZAIR','ZAIM') THEN 1
                  WHEN AW.mandant_id = 1 AND angebot_typ_cd NOT IN ('ZAI','ZAIR','ZAIM') THEN 1
                  WHEN angebot_typ_cd NOT IN ('0009','ZAI','ZAIR','ZAIM','0010','ZB09','ZB10') THEN 1
                  ELSE 0
              END = 1
    )
    SELECT DISTINCT
        mandant_id,
        kjwo,
        angebot_id,
        aktion_id,
        ausliefergruppe_id,
        art_id,
        wup_id_vz,
        nb_id_vz,
        mandant_id_vz,        
        -9,
        COALESCE(gp_id, -9),
        :P_CLEAR_STOCK_FG,
        NULL,
        :P_ESTIMATION_FG,
        :P_MAX_KAPA_FG,
        :P_ADJUSTMENT_FG,
        :P_DAT_LETZTE_NACHVERSORGUNG,
        :P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
        :P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    FROM Angebot_Artikel
    WHERE mandant_id = :P_MANDANT_ID
      AND KJWO IN (
          SELECT TRIM(table1.value)
          FROM TABLE(split_to_table(:P_KJWO, ',')) AS table1
      )
      AND ART_ID IN (
          SELECT TRIM(table1.value)
          FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1
          HAVING LENGTH(table1.value) > 1
      )
      AND GP_ID IN (
          SELECT TRIM(table1.value)
          FROM TABLE(split_to_table(:P_GPS, ',')) AS table1
      )
      AND ANGEBOT_ID IN (
          SELECT TRIM(table1.value)
          FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1
      )
      AND NOT (KJWO, ART_ID, gp_id, angebot_id) IN (
          SELECT KJWO, ART_ID, gp_id, angebot_nr
          FROM Art_UPDATE
      );

    COMMIT;

    RETURN 'Artikel_1 abgespeichert';

END;
$$;