CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_ausliefergruppe(IN P_MANDANT_ID FLOAT64, IN P_AUSLIEFERGRUPPE_ID STRING, IN P_FAKTOR_REST_VON_NORMALBESTAND FLOAT64, IN P_BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ FLOAT64, IN P_BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ FLOAT64, IN P_BERECHNUNG_KOLLI_RUNDUNG_PROZ FLOAT64, IN P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ FLOAT64, IN P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ FLOAT64, IN P_NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ FLOAT64, IN P_FAKTOR_MAX_KAPA_ENDBESTAND FLOAT64, IN P_FAKTOR_BESTAND_BETRACHTUNG FLOAT64, IN P_ERWEITERUNG_BEDARFSHORIZONT_TAGE FLOAT64, IN P_MENGE_ZIELENDBESTAND_SCHWELLWERT_AME FLOAT64, IN P_DELETE_FG INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
--, :P_ADJUSTMENT_FG AS adjustment_fg
--, :P_LIEFERUNG_TAG_OFFSET AS lieferung_tag_offset
--, :P_ESTIMATION_FG AS estimation_fg
--, target.adjustment_id = SOURCE.adjustment_fg
--, target.lieferung_tag_offset = SOURCE.lieferung_tag_offset
--, target.estimation_fg = SOURCE.estimation_fg
/*adjustment_id,*/
/*lieferung_tag_offset,estimation_fg,*/
--, source.adjustment_fg
--, source.lieferung_tag_offset
--, source.estimation_fg
MERGE INTO dbp_data.ts_wbs_ausliefergruppe_1 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_AUSLIEFERGRUPPE_ID AS ausliefergruppe_id, P_FAKTOR_REST_VON_NORMALBESTAND AS faktor_rest_von_normalbestand, P_BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ AS berechnung_schwellwert_pal_abrundung_proz, P_BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ AS berechnung_schwellwert_pal_aufrundung_proz, P_BERECHNUNG_KOLLI_RUNDUNG_PROZ AS berechnung_kolli_rundung_proz, P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ AS nachversorgung_schwellwert_pal_abrundung_proz, P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ AS nachversorgung_schwellwert_pal_aufrundung_proz, P_NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ AS nachversorgung_kolli_rundung_proz, P_FAKTOR_MAX_KAPA_ENDBESTAND AS faktor_max_kapa_endbestand, P_FAKTOR_BESTAND_BETRACHTUNG AS faktor_bestand_betrachtung, P_ERWEITERUNG_BEDARFSHORIZONT_TAGE AS erweiterung_bedarfshorizont_tage, P_MENGE_ZIELENDBESTAND_SCHWELLWERT_AME AS menge_zielendbestand_schwellwert_ame) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.ausliefergruppe_id = source.ausliefergruppe_id
WHEN MATCHED AND P_DELETE_FG = 0 THEN UPDATE SET
    rest_von_normalbestand_proz = CAST(source.faktor_rest_von_normalbestand  AS NUMERIC),
    berechnung_schwellwert_pal_abrundung_proz = CAST(source.berechnung_schwellwert_pal_abrundung_proz  AS NUMERIC),
    berechnung_schwellwert_pal_aufrundung_proz = CAST(source.berechnung_schwellwert_pal_aufrundung_proz  AS NUMERIC),
    berechnung_kolli_rundung_proz = CAST(source.berechnung_kolli_rundung_proz  AS NUMERIC),
    nachversorgung_schwellwert_pal_abrundung_proz = CAST(source.nachversorgung_schwellwert_pal_abrundung_proz  AS NUMERIC),
    nachversorgung_schwellwert_pal_aufrundung_proz = CAST(source.nachversorgung_schwellwert_pal_aufrundung_proz  AS NUMERIC),
    nachversorgung_kolli_rundung_proz = CAST(source.nachversorgung_kolli_rundung_proz  AS NUMERIC),
    ausliefergruppe_id = source.ausliefergruppe_id,
    max_kapa_endbestand_proz = CAST(source.faktor_max_kapa_endbestand  AS NUMERIC),
    bestand_betrachtung_proz = CAST(source.faktor_bestand_betrachtung  AS NUMERIC),
    erweiterung_bedarfshorizont_tage = CAST(source.erweiterung_bedarfshorizont_tage AS INTEGER),
    menge_zielendbestand_schwellwert_ame = CAST(source.menge_zielendbestand_schwellwert_ame AS INTEGER),
    td_update = CURRENT_TIMESTAMP()
WHEN MATCHED AND P_DELETE_FG = 1 THEN
DELETE
WHEN NOT MATCHED THEN INSERT VALUES(CAST(source.mandant_id AS INTEGER), source.ausliefergruppe_id, CAST(source.berechnung_schwellwert_pal_abrundung_proz  AS NUMERIC), CAST(source.berechnung_schwellwert_pal_aufrundung_proz  AS NUMERIC), CAST(source.berechnung_kolli_rundung_proz  AS NUMERIC), CAST(source.nachversorgung_schwellwert_pal_abrundung_proz  AS NUMERIC), CAST(source.nachversorgung_schwellwert_pal_aufrundung_proz  AS NUMERIC), CAST(source.nachversorgung_kolli_rundung_proz  AS NUMERIC), CAST(source.faktor_max_kapa_endbestand  AS NUMERIC), CAST(source.faktor_bestand_betrachtung  AS NUMERIC), CAST(source.faktor_rest_von_normalbestand  AS NUMERIC), CAST(source.erweiterung_bedarfshorizont_tage AS INTEGER), CAST(source.menge_zielendbestand_schwellwert_ame AS INTEGER), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
COMMIT TRANSACTION;
SET out_param  =  'Ausliefergruppe geaendert';
SELECT out_param;
RETURN;
END;

