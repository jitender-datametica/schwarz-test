CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_MENGENAENDERUNGEN_WRITEBACK(
     P_MANDANT_ID NUMBER, 
    P_AKTION_ID VARCHAR(10), 
    P_DAT_VON VARCHAR(16777216), 
    P_DAT_BIS VARCHAR(16777216), 
    P_ANGEBOT_ID NUMBER, 
    P_DAT_BELADUNG VARCHAR(16777216), 
    P_MENGE_OHNE_BESTAND_GENEHMIGT_FG NUMBER, 
    P_MENGE_MIT_BESTAND_GENEHMIGT_FG NUMBER,    

    P_WERBEAENDERUNG_MENGE_UEBERTRAGEN NUMBER, 
	P_WFL_MENGE_GEPRUEFT_FG NUMBER,
    P_WFL_NUTZER_KOMMENTAR_TXT VARCHAR(16777216),
    P_FIXMENGE_WFL_BME NUMBER,
    P_MENGE_MINDESTPLATZIERUNG_CLUSTER_1_AME NUMBER,
    P_MENGE_MINDESTPLATZIERUNG_CLUSTER_2_AME NUMBER,
    P_MENGE_MINDESTPLATZIERUNG_CLUSTER_3_AME NUMBER,
    P_ESTIMATION_ID NUMBER,
    P_ADJUSTMENT_ID NUMBER,
    P_ART_ID NUMBER)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS OWNER
AS 
$$
BEGIN

MERGE INTO DBP_DATA.ts_mengenaenderungen_writeback_1 as target
    USING (
    SELECT DISTINCT
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
		, :P_wfl_menge_geprueft_fg AS wfl_menge_geprueft_fg
        , :P_wfl_nutzer_kommentar_txt AS wfl_nutzer_kommentar_txt
        , :P_fixmenge_wfl_bme AS fixmenge_wfl_bme
        , :P_menge_mindestplatzierung_cluster_1_ame AS menge_mindestplatzierung_cluster_1_ame
        , :P_menge_mindestplatzierung_cluster_2_ame AS menge_mindestplatzierung_cluster_2_ame
        , :P_menge_mindestplatzierung_cluster_3_ame AS menge_mindestplatzierung_cluster_3_ame
        , :P_estimation_id AS estimation_id
        , :P_adjustment_id AS adjustment_id
        , estimation_id AS estimation_id_werbeaenderungen
        , adjustment_id AS adjustment_id_werbeaenderungen
        FROM dbp_view.v_wbs_werbeaenderungen_1
        where mandant_id=:P_MANDANT_ID and aktion_id=:P_aktion_id and dat_ab=:P_dat_von and dat_bis=:P_dat_bis
        and angebot_id=:P_angebot_id and dat_beladung=:P_dat_beladung and art_id=:P_art_id 
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
                werbeaenderung_menge_uebertragen = NULL,
                target.wfl_menge_geprueft_fg = source.wfl_menge_geprueft_fg,
                --target.wfl_nutzer_kommentar_txt = (CASE WHEN source.wfl_nutzer_kommentar_txt='' THEN NULL ELSE source.wfl_nutzer_kommentar_txt END),
                target.wfl_nutzer_kommentar_txt = CASE WHEN source.wfl_nutzer_kommentar_txt IS NULL THEN '-' ELSE source.wfl_nutzer_kommentar_txt END,
                --target.fixmenge_wfl_bme = source.fixmenge_wfl_bme,
                target.fixmenge_wfl_bme = CASE WHEN source.fixmenge_wfl_bme IS NULL THEN 0 ELSE source.fixmenge_wfl_bme END,
                target.menge_mindestplatzierung_cluster_1_ame = CASE WHEN source.menge_mindestplatzierung_cluster_1_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_1_ame END,
                target.menge_mindestplatzierung_cluster_2_ame = CASE WHEN source.menge_mindestplatzierung_cluster_2_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_2_ame END,
                target.menge_mindestplatzierung_cluster_3_ame = CASE WHEN source.menge_mindestplatzierung_cluster_3_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_3_ame END,
                target.estimation_id = source.estimation_id,
                target.adjustment_id = source.adjustment_id,
                TD_UPDATE = CURRENT_TIMESTAMP
                
				
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
            menge_mindestplatzierung_cluster_1_ame,
            menge_mindestplatzierung_cluster_2_ame,
            menge_mindestplatzierung_cluster_3_ame,
            estimation_id,
            adjustment_id,
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
	, source.wfl_menge_geprueft_fg
    , CASE WHEN source.wfl_nutzer_kommentar_txt IS NULL THEN '-' ELSE source.wfl_nutzer_kommentar_txt END
    , CASE WHEN source.fixmenge_wfl_bme IS NULL THEN 0 ELSE source.fixmenge_wfl_bme END
    , CASE WHEN source.menge_mindestplatzierung_cluster_1_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_1_ame END
    , CASE WHEN source.menge_mindestplatzierung_cluster_2_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_2_ame END
    , CASE WHEN source.menge_mindestplatzierung_cluster_3_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_3_ame END
    --, source.estimation_id
    , CASE WHEN source.estimation_id= COALESCE(estimation_id_werbeaenderungen,0) THEN NULL ELSE source.estimation_id END
    , CASE WHEN source.adjustment_id= COALESCE(adjustment_id_werbeaenderungen,0) THEN NULL ELSE source.adjustment_id END
    , CURRENT_TIMESTAMP
    , CURRENT_TIMESTAMP
    );

COMMIT;
RETURN 'Freeze Writeback angepasst';
END;

$$;