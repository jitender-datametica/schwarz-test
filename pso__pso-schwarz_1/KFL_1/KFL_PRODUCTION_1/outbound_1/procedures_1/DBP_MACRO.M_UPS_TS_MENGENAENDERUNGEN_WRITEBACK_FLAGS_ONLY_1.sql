CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_mengenaenderungen_writeback_flags_only(IN P_MANDANT_ID INT64, IN P_AKTION_ID STRING, IN P_DAT_VON STRING, IN P_DAT_BIS STRING, IN P_ANGEBOT_ID INT64, IN P_DAT_BELADUNG STRING, IN P_MENGE_OHNE_BESTAND_GENEHMIGT_FG INT64, IN P_MENGE_MIT_BESTAND_GENEHMIGT_FG INT64, IN P_WERBEAENDERUNG_MENGE_UEBERTRAGEN INT64, IN P_ART_ID INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO dbp_data.ts_mengenaenderungen_writeback_1 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, P_DAT_VON AS dat_von, P_DAT_BIS AS dat_bis, P_ANGEBOT_ID AS angebot_id, P_DAT_BELADUNG AS dat_beladung, P_ART_ID AS art_id, P_MENGE_OHNE_BESTAND_GENEHMIGT_FG AS menge_ohne_bestand_genehmigt_fg, P_MENGE_MIT_BESTAND_GENEHMIGT_FG AS menge_mit_bestand_genehmigt_fg, P_WERBEAENDERUNG_MENGE_UEBERTRAGEN AS werbeaenderung_menge_uebertragen) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.aktion_id = source.aktion_id AND TARGET.dat_von = CAST(source.dat_von AS DATE) AND TARGET.dat_bis = CAST(source.dat_bis AS DATE) AND TARGET.angebot_id = source.angebot_id AND TARGET.dat_beladung = CAST(source.dat_beladung AS DATE) AND TARGET.art_id = source.art_id
WHEN MATCHED THEN UPDATE SET
    menge_ohne_bestand_genehmigt_fg = source.menge_ohne_bestand_genehmigt_fg ,
    menge_mit_bestand_genehmigt_fg = source.menge_mit_bestand_genehmigt_fg ,
    werbeaenderung_menge_uebertragen = NULL
WHEN NOT MATCHED THEN INSERT (mandant_id, aktion_id, art_id, dat_von, dat_bis, angebot_id, dat_beladung, menge_ohne_bestand_genehmigt_fg, menge_mit_bestand_genehmigt_fg, werbeaenderung_menge_uebertragen, fixmenge_wfl_bme, menge_mindestplatzierung_cluster_1_ame, menge_mindestplatzierung_cluster_2_ame, menge_mindestplatzierung_cluster_3_ame, wfl_menge_geprueft_fg, wfl_nutzer_kommentar_txt, estimation_id, td_update, td_insert) VALUES(source.mandant_id , source.aktion_id, source.art_id , CAST(source.dat_von AS DATE), CAST(source.dat_bis AS DATE), source.angebot_id , CAST(source.dat_beladung AS DATE), source.menge_ohne_bestand_genehmigt_fg , source.menge_mit_bestand_genehmigt_fg , CAST(NULL AS NUMERIC), NULL , NULL , NULL , NULL , NULL , CAST(NULL AS STRING), NULL , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
COMMIT TRANSACTION;
SET out_param  =  'Freeze Writeback angepasst';
SELECT out_param;
RETURN;
END;


