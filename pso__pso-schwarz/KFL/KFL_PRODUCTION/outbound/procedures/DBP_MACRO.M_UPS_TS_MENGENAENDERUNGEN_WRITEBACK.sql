CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_mengenaenderungen_writeback(IN P_MANDANT_ID BIGNUMERIC,
 IN P_AKTION_ID STRING,
 IN P_DAT_VON STRING,
 IN P_DAT_BIS STRING,
 IN P_ANGEBOT_ID BIGNUMERIC,
 IN P_DAT_BELADUNG STRING,
 IN P_MENGE_OHNE_BESTAND_GENEHMIGT_FG BIGNUMERIC,
 IN P_MENGE_MIT_BESTAND_GENEHMIGT_FG BIGNUMERIC,
 IN P_WERBEAENDERUNG_MENGE_UEBERTRAGEN BIGNUMERIC,
 IN P_WFL_MENGE_GEPRUEFT_FG BIGNUMERIC,
 IN P_WFL_NUTZER_KOMMENTAR_TXT STRING,
 IN P_FIXMENGE_WFL_BME BIGNUMERIC,
 IN P_MENGE_MINDESTPLATZIERUNG_CLUSTER_1_AME BIGNUMERIC,
 IN P_MENGE_MINDESTPLATZIERUNG_CLUSTER_2_AME BIGNUMERIC,
 IN P_MENGE_MINDESTPLATZIERUNG_CLUSTER_3_AME BIGNUMERIC,
 IN P_ESTIMATION_ID BIGNUMERIC,
 IN P_ADJUSTMENT_ID BIGNUMERIC,
 IN P_ART_ID BIGNUMERIC,
 OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
--target.wfl_nutzer_kommentar_txt = (CASE WHEN source.wfl_nutzer_kommentar_txt='' THEN NULL ELSE source.wfl_nutzer_kommentar_txt END),
--target.fixmenge_wfl_bme = source.fixmenge_wfl_bme,
--, source.estimation_id
MERGE INTO dbp_data.ts_mengenaenderungen_writeback AS TARGET
USING (SELECT DISTINCT P_MANDANT_ID AS mandant_id,
 P_AKTION_ID AS aktion_id,
 P_DAT_VON AS dat_von,
 P_DAT_BIS AS dat_bis,
 P_ANGEBOT_ID AS angebot_id,
 P_DAT_BELADUNG AS dat_beladung,
 P_ART_ID AS art_id,
 P_MENGE_OHNE_BESTAND_GENEHMIGT_FG AS menge_ohne_bestand_genehmigt_fg,
 P_MENGE_MIT_BESTAND_GENEHMIGT_FG AS menge_mit_bestand_genehmigt_fg,
 P_WERBEAENDERUNG_MENGE_UEBERTRAGEN AS werbeaenderung_menge_uebertragen,
 P_WFL_MENGE_GEPRUEFT_FG AS wfl_menge_geprueft_fg,
 P_WFL_NUTZER_KOMMENTAR_TXT AS wfl_nutzer_kommentar_txt,
 P_FIXMENGE_WFL_BME AS fixmenge_wfl_bme,
 P_MENGE_MINDESTPLATZIERUNG_CLUSTER_1_AME AS menge_mindestplatzierung_cluster_1_ame,
 P_MENGE_MINDESTPLATZIERUNG_CLUSTER_2_AME AS menge_mindestplatzierung_cluster_2_ame,
 P_MENGE_MINDESTPLATZIERUNG_CLUSTER_3_AME AS menge_mindestplatzierung_cluster_3_ame,
 P_ESTIMATION_ID AS estimation_id,
 P_ADJUSTMENT_ID AS adjustment_id,
 estimation_id AS estimation_id_werbeaenderungen,
 adjustment_id AS adjustment_id_werbeaenderungen
    FROM dbp_view.v_wbs_werbeaenderungen
    WHERE mandant_id = P_MANDANT_ID AND aktion_id = P_AKTION_ID AND dat_ab = CAST(P_DAT_VON AS DATE) 
    AND dat_bis = CAST(P_DAT_BIS AS DATE) 
    AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE) 
    AND art_id = P_ART_ID AND P_ANGEBOT_ID IS NOT NULL) AS source
ON TARGET.mandant_id = source.mandant_id 
    AND TARGET.aktion_id = source.aktion_id 
    AND TARGET.dat_von = CAST(source.dat_von AS DATE) 
    AND TARGET.dat_bis = CAST(source.dat_bis AS DATE) 
    AND TARGET.angebot_id = source.angebot_id 
    AND TARGET.dat_beladung = CAST(source.dat_beladung AS DATE) AND TARGET.art_id = source.art_id
WHEN MATCHED THEN UPDATE SET
    menge_ohne_bestand_genehmigt_fg = CAST(source.menge_ohne_bestand_genehmigt_fg AS INTEGER),
    menge_mit_bestand_genehmigt_fg = CAST(source.menge_mit_bestand_genehmigt_fg AS INTEGER),
    werbeaenderung_menge_uebertragen = NULL,
    wfl_menge_geprueft_fg = CAST(source.wfl_menge_geprueft_fg AS INTEGER),
    wfl_nutzer_kommentar_txt = CASE WHEN source.wfl_nutzer_kommentar_txt IS NULL THEN '-' ELSE source.wfl_nutzer_kommentar_txt END,
    fixmenge_wfl_bme = CAST(CASE WHEN source.fixmenge_wfl_bme IS NULL THEN 0 ELSE source.fixmenge_wfl_bme END AS INTEGER),
    menge_mindestplatzierung_cluster_1_ame = CAST(CASE WHEN source.menge_mindestplatzierung_cluster_1_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_1_ame END AS INTEGER),
    menge_mindestplatzierung_cluster_2_ame = CAST(CASE WHEN source.menge_mindestplatzierung_cluster_2_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_2_ame END AS INTEGER),
    menge_mindestplatzierung_cluster_3_ame = CAST(CASE WHEN source.menge_mindestplatzierung_cluster_3_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_3_ame END AS INTEGER),
    estimation_id = CAST(source.estimation_id AS INTEGER),
    adjustment_id = CAST(source.adjustment_id AS INTEGER),
    td_update = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT (mandant_id,
    aktion_id,
    art_id,
    dat_von,
    dat_bis,
    angebot_id,
    dat_beladung,
    menge_ohne_bestand_genehmigt_fg,
    menge_mit_bestand_genehmigt_fg,
    werbeaenderung_menge_uebertragen,
    fixmenge_wfl_bme,
    menge_mindestplatzierung_cluster_1_ame,
    menge_mindestplatzierung_cluster_2_ame,
    menge_mindestplatzierung_cluster_3_ame,
    wfl_menge_geprueft_fg,
    wfl_nutzer_kommentar_txt,
    estimation_id,
    adjustment_id,
    td_update,
    td_insert) 
    VALUES(CAST(source.mandant_id AS INTEGER),
    source.aktion_id,
    CAST(source.art_id AS INTEGER),
    CAST(source.dat_von AS DATE),
    CAST(source.dat_bis AS DATE),
    CAST(source.angebot_id AS INTEGER),
    CAST(source.dat_beladung AS DATE),
    CAST(source.menge_ohne_bestand_genehmigt_fg AS INTEGER),
    CAST(source.menge_mit_bestand_genehmigt_fg AS INTEGER),
    CAST(NULL AS NUMERIC),
    CAST(CASE WHEN source.fixmenge_wfl_bme IS NULL THEN 0 ELSE source.fixmenge_wfl_bme END AS INTEGER),
    CAST(CASE WHEN source.menge_mindestplatzierung_cluster_1_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_1_ame END AS INTEGER),
    CAST(CASE WHEN source.menge_mindestplatzierung_cluster_2_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_2_ame END AS INTEGER),
    CAST(CASE WHEN source.menge_mindestplatzierung_cluster_3_ame IS NULL THEN 0 ELSE source.menge_mindestplatzierung_cluster_3_ame END AS INTEGER),
    CAST(source.wfl_menge_geprueft_fg AS INTEGER),
    CASE WHEN source.wfl_nutzer_kommentar_txt IS NULL THEN '-' ELSE source.wfl_nutzer_kommentar_txt END,
    CAST(CASE WHEN source.estimation_id = COALESCE(source.estimation_id_werbeaenderungen,
    0) THEN NULL ELSE source.estimation_id END AS INTEGER),
    CAST(CASE WHEN source.adjustment_id = COALESCE(source.adjustment_id_werbeaenderungen,
    0) THEN NULL ELSE source.adjustment_id END AS INTEGER),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP());
COMMIT TRANSACTION;
SET out_param  =  'Freeze Writeback angepasst';
SELECT out_param;
RETURN;
END;