CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_MENGENAENDERUNGEN_WRITEBACK_FLAGS_ONLY(
     P_MANDANT_ID NUMBER, 
    P_AKTION_ID VARCHAR(10), 
    P_DAT_VON VARCHAR(16777216), 
    P_DAT_BIS VARCHAR(16777216), 
    P_ANGEBOT_ID NUMBER, 
    P_DAT_BELADUNG VARCHAR(16777216), 
    P_MENGE_OHNE_BESTAND_GENEHMIGT_FG NUMBER, 
    P_MENGE_MIT_BESTAND_GENEHMIGT_FG NUMBER,
    P_WERBEAENDERUNG_MENGE_UEBERTRAGEN NUMBER, 
    P_ART_ID NUMBER)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS OWNER
AS 
$$
BEGIN

MERGE INTO DBP_DATA.ts_mengenaenderungen_writeback_2 as target
    USING (
    SELECT
        :P_MANDANT_ID        AS mandant_id
        , :P_aktion_id       AS aktion_id
        , :P_dat_von         AS dat_von
        , :P_dat_bis         AS dat_bis
        , :P_angebot_id      AS angebot_id
        , :P_dat_beladung    AS dat_beladung
        , :P_art_id          AS art_id
        , :P_menge_ohne_bestand_genehmigt_fg AS menge_ohne_bestand_genehmigt_fg
        , :P_menge_mit_bestand_genehmigt_fg  AS menge_mit_bestand_genehmigt_fg
        , :P_werbeaenderung_menge_uebertragen AS werbeaenderung_menge_uebertragen
								   
    ) AS source
    ON target.mandant_id = SOURCE.mandant_id
        AND target.aktion_id = SOURCE.aktion_id
        AND target.dat_von = SOURCE.dat_von
        AND target.dat_bis = SOURCE.dat_bis
        AND target.angebot_id = SOURCE.angebot_id
        AND target.dat_beladung = SOURCE.dat_beladung
        AND target.art_id = SOURCE.art_id
WHEN MATCHED THEN
    UPDATE SET target.menge_ohne_bestand_genehmigt_fg = source.menge_ohne_bestand_genehmigt_fg, 
                target.menge_mit_bestand_genehmigt_fg = source.menge_mit_bestand_genehmigt_fg, 
                werbeaenderung_menge_uebertragen = NULL
                   
				
WHEN NOT MATCHED THEN
    INSERT (mandant_id, 
            aktion_id, 
            art_id, 
            dat_von, 
            dat_bis, 
            angebot_id, 
            dat_beladung, 
            menge_ohne_bestand_genehmigt_fg,
            menge_mit_bestand_genehmigt_fg, 
            werbeaenderung_menge_uebertragen,
              wfl_menge_geprueft_fg ,
            wfl_nutzer_kommentar_txt ,
            fixmenge_wfl_bme ,
            menge_mindestplatzierung_cluster_1_ame ,
            menge_mindestplatzierung_cluster_2_ame ,
            menge_mindestplatzierung_cluster_3_ame,
            estimation_id,
            TD_UPDATE,
            TD_INSERT)
    VALUES (
    source.mandant_id
    , source.aktion_id
    , source.art_id
    , source.dat_von
    , source.dat_bis
    , source.angebot_id
    , source.dat_beladung
    , source.menge_ohne_bestand_genehmigt_fg
    , source.menge_mit_bestand_genehmigt_fg
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , NULL
    , CURRENT_TIMESTAMP
    , CURRENT_TIMESTAMP
    );

COMMIT;
RETURN 'Freeze Writeback angepasst';
END;

$$;