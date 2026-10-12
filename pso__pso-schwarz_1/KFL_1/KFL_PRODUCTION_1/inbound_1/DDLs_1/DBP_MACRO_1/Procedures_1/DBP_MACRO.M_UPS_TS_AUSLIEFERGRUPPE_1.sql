CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_AUSLIEFERGRUPPE(
P_MANDANT_ID FLOAT,
 P_AUSLIEFERGRUPPE_ID VARCHAR(10),
P_FAKTOR_REST_VON_NORMALBESTAND FLOAT, 
P_BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ FLOAT,
P_BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ FLOAT,
P_BERECHNUNG_KOLLI_RUNDUNG_PROZ FLOAT,
P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ FLOAT,
P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ FLOAT,
P_NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ FLOAT,
P_FAKTOR_MAX_KAPA_ENDBESTAND FLOAT,
P_FAKTOR_BESTAND_BETRACHTUNG FLOAT,
P_ERWEITERUNG_BEDARFSHORIZONT_TAGE FLOAT,
P_MENGE_ZIELENDBESTAND_SCHWELLWERT_AME FLOAT,
P_DELETE_FG NUMBER(38,0))
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS 
$$
BEGIN

MERGE INTO DBP_DATA.ts_wbs_ausliefergruppe_1 as target 
USING (
	SELECT
		 :P_MANDANT_ID AS mandant_id
		, :P_AUSLIEFERGRUPPE_ID AS ausliefergruppe_id
		, :P_FAKTOR_REST_VON_NORMALBESTAND AS faktor_rest_von_normalbestand
		, :P_BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ AS berechnung_schwellwert_pal_abrundung_proz
		, :P_BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ AS berechnung_schwellwert_pal_aufrundung_proz
		, :P_BERECHNUNG_KOLLI_RUNDUNG_PROZ AS berechnung_kolli_rundung_proz
        , :P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ AS nachversorgung_schwellwert_pal_abrundung_proz
		, :P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ AS nachversorgung_schwellwert_pal_aufrundung_proz
		, :P_NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ AS nachversorgung_kolli_rundung_proz
		, :P_FAKTOR_MAX_KAPA_ENDBESTAND AS faktor_max_kapa_endbestand
		--, :P_ADJUSTMENT_FG AS adjustment_fg
        , :P_FAKTOR_BESTAND_BETRACHTUNG AS faktor_bestand_betrachtung
		--, :P_LIEFERUNG_TAG_OFFSET AS lieferung_tag_offset
		--, :P_ESTIMATION_FG AS estimation_fg
        , :P_ERWEITERUNG_BEDARFSHORIZONT_TAGE AS erweiterung_bedarfshorizont_tage
        , :P_MENGE_ZIELENDBESTAND_SCHWELLWERT_AME AS menge_zielendbestand_schwellwert_ame


	) AS source
	ON target.mandant_id = SOURCE.mandant_id
			AND target.ausliefergruppe_id = SOURCE.ausliefergruppe_id
	WHEN MATCHED AND :P_DELETE_FG=0 THEN
			UPDATE SET target.rest_von_normalbestand_proz = SOURCE.faktor_rest_von_normalbestand
			   , target.berechnung_schwellwert_pal_abrundung_proz = SOURCE.berechnung_schwellwert_pal_abrundung_proz
			   , target.berechnung_schwellwert_pal_aufrundung_proz = SOURCE.berechnung_schwellwert_pal_aufrundung_proz
               , target.berechnung_kolli_rundung_proz = SOURCE.berechnung_kolli_rundung_proz
			   , target.nachversorgung_schwellwert_pal_abrundung_proz = SOURCE.nachversorgung_schwellwert_pal_abrundung_proz
			   , target.nachversorgung_schwellwert_pal_aufrundung_proz = SOURCE.nachversorgung_schwellwert_pal_aufrundung_proz
			   , target.nachversorgung_kolli_rundung_proz = SOURCE.nachversorgung_kolli_rundung_proz
			   , target.ausliefergruppe_id = SOURCE.ausliefergruppe_id
			   , target.max_kapa_endbestand_proz = SOURCE.faktor_max_kapa_endbestand
			   --, target.adjustment_id = SOURCE.adjustment_fg
			   , target.bestand_betrachtung_proz = SOURCE.faktor_bestand_betrachtung
			   --, target.lieferung_tag_offset = SOURCE.lieferung_tag_offset
			   --, target.estimation_fg = SOURCE.estimation_fg
               , target.erweiterung_bedarfshorizont_tage = SOURCE.erweiterung_bedarfshorizont_tage
               , target.menge_zielendbestand_schwellwert_ame = SOURCE.menge_zielendbestand_schwellwert_ame
               , target.td_update= CURRENT_TIMESTAMP
               
  WHEN MATCHED AND :P_DELETE_FG=1  THEN
    DELETE  
    
	WHEN NOT MATCHED THEN
		INSERT (mandant_id, ausliefergruppe_id, rest_von_normalbestand_proz, berechnung_schwellwert_pal_abrundung_proz, berechnung_schwellwert_pal_aufrundung_proz, 
		berechnung_kolli_rundung_proz,nachversorgung_schwellwert_pal_abrundung_proz, nachversorgung_schwellwert_pal_aufrundung_proz, nachversorgung_kolli_rundung_proz, max_kapa_endbestand_proz,/*adjustment_id,*/ bestand_betrachtung_proz, 
    /*lieferung_tag_offset,estimation_fg,*/erweiterung_bedarfshorizont_tage,menge_zielendbestand_schwellwert_ame, td_update, td_insert)
		VALUES (
			source.mandant_id
			, source.ausliefergruppe_id
			, source.faktor_rest_von_normalbestand
			, source.berechnung_schwellwert_pal_abrundung_proz
			, source.berechnung_schwellwert_pal_aufrundung_proz
			, source.berechnung_kolli_rundung_proz
            , source.nachversorgung_schwellwert_pal_abrundung_proz
			, source.nachversorgung_schwellwert_pal_aufrundung_proz
			, source.nachversorgung_kolli_rundung_proz
			, source.faktor_max_kapa_endbestand
			--, source.adjustment_fg
			, source.faktor_bestand_betrachtung
			--, source.lieferung_tag_offset
			--, source.estimation_fg
            , source.erweiterung_bedarfshorizont_tage
            , source.menge_zielendbestand_schwellwert_ame
            , CURRENT_TIMESTAMP
            , CURRENT_TIMESTAMP);
COMMIT;
RETURN 'Ausliefergruppe geaendert';
END;
$$;