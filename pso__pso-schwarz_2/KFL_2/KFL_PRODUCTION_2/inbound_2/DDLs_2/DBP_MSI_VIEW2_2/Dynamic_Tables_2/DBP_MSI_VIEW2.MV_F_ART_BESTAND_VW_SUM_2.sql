CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_F_ART_BESTAND_VW_SUM_2
(
	MANDANT_ID,
	ART_ID,
	STIMMIG_ID,
	DAT,
	GP_ID,
	WRG_ID,
	DS_VZ_BESTAND_MENGE_FREI,
	DS_VZ_BESTAND_MENGE_GES,
	DS_VZ_BESTAND_MENGE_QUAL,
	DS_VZ_BESTAND_KLEP_FREI,
	DS_VZ_BESTAND_KLEP_GES,
	DS_VZ_BESTAND_MEP_FREI,
	DS_VZ_BESTAND_MEP_GES,
	DS_VZ_BESTAND_EKN_FREI,
	DS_VZ_BESTAND_EKN_GES,
	DS_VZ_BESTAND_EKN_BNK_FREI,
	DS_VZ_BESTAND_EKN_BNK_GES,
	DS_VZ_BESTAND_VKN_FREI,
	DS_VZ_BESTAND_VKN_GES,
	VZ_VERBRAUCH_MENGE,
	VZ_VERBRAUCH_KLEP,
	VZ_VERBRAUCH_MEP,
	VZ_VERBRAUCH_EKN,
	VZ_VERBRAUCH_EKN_BNK,
	DS_MARKT_BESTAND_MENGE_FREI,
	DS_MARKT_BESTAND_MENGE_GES,
	DS_MARKT_BESTAND_MENGE_QUAL,
	DS_MARKT_BESTAND_KLEP_FREI,
	DS_MARKT_BESTAND_KLEP_GES,
	DS_MARKT_BESTAND_MEP_FREI,
	DS_MARKT_BESTAND_MEP_GES,
	DS_MARKT_BESTAND_EKN_FREI,
	DS_MARKT_BESTAND_EKN_GES,
	DS_MARKT_BESTAND_EKN_BNK_FREI,
	DS_MARKT_BESTAND_EKN_BNK_GES,
	DS_MARKT_BESTAND_VKN_FREI,
	DS_MARKT_BESTAND_VKN_GES,
	MARKT_VERBRAUCH_MENGE,
	MARKT_VERBRAUCH_KLEP,
	MARKT_VERBRAUCH_MEP,
	MARKT_VERBRAUCH_EKN,
	MARKT_VERBRAUCH_EKN_BNK
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
-- 2022-07-12, AP0125093, SPEC0161886, dknop, replacing join to art_wup_ek_zu_per_2
   SELECT
    t1.mandant_id
   ,t1.art_id
   ,t1.relevant_fg AS stimmig_id
   ,t1.dat
   ,t1.gp_id
   ,t3.wrg_id
   ,CAST(t1.menge_lgbest_erp_frei_bme  * t1.lagerbestand_fg   AS NUMBER(38,5)) AS ds_vz_bestand_menge_frei
   ,CAST(t1.menge_lgbest_erp_gesamt_bme * t1.lagerbestand_fg   AS NUMBER(38,5)) AS ds_vz_bestand_menge_ges
   ,CAST(t1.menge_lgbest_erp_qual_bme  * t1.lagerbestand_fg   AS NUMBER(38,5)) AS ds_vz_bestand_menge_qual
   ,CAST(ds_vz_bestand_menge_frei  * t3.einstandspreis   AS NUMBER(38,5)) AS ds_vz_bestand_klep_frei
   ,CAST(ds_vz_bestand_menge_ges  * t3.einstandspreis   AS NUMBER(38,5)) AS ds_vz_bestand_klep_ges
   ,CAST(ds_vz_bestand_menge_frei  * t3.ek_mep    AS NUMBER(38,5)) AS ds_vz_bestand_mep_frei
   ,CAST(ds_vz_bestand_menge_ges  * t3.ek_mep    AS NUMBER(38,5)) AS ds_vz_bestand_mep_ges
   ,CAST(ds_vz_bestand_menge_frei  * t3.ek_netto    AS NUMBER(38,5)) AS ds_vz_bestand_ekn_frei
   ,CAST(ds_vz_bestand_menge_ges  * t3.ek_netto    AS NUMBER(38,5)) AS ds_vz_bestand_ekn_ges
   ,CAST(ds_vz_bestand_menge_frei  * t3.ek_netto_bnk   AS NUMBER(38,5)) AS ds_vz_bestand_ekn_bnk_frei
   ,CAST(ds_vz_bestand_menge_ges  * t3.ek_netto_bnk   AS NUMBER(38,5)) AS ds_vz_bestand_ekn_bnk_ges
   ,CAST(betrag_vk_netto_frei_bme  * t1.lagerbestand_fg   AS NUMBER(38,5)) AS ds_vz_bestand_vkn_frei
   ,CAST(betrag_vk_netto_gesamt_bme  * t1.lagerbestand_fg   AS NUMBER(38,5)) AS ds_bestand_vz_vkn_ges
   ,CAST(menge_abgang_bme   * t1.lagerbestand_fg   AS NUMBER(38,5)) AS vz_verbrauch_menge
   ,CAST(vz_verbrauch_menge   * t3.einstandspreis   AS NUMBER(38,5)) AS vz_verbrauch_klep
   ,CAST(vz_verbrauch_menge   * t3.ek_mep    AS NUMBER(38,5)) AS vz_verbrauch_mep
   ,CAST(vz_verbrauch_menge   * t3.ek_netto    AS NUMBER(38,5)) AS vz_verbrauch_ekn
   ,CAST(vz_verbrauch_menge   * t3.ek_netto_bnk   AS NUMBER(38,5)) AS vz_verbrauch_ekn_bnk
   ,CAST(t1.menge_lgbest_erp_frei_bme  *(t1.lagerbestand_fg-1)*(-1)  AS NUMBER(38,5)) AS ds_markt_bestand_menge_frei
   ,CAST(t1.menge_lgbest_erp_gesamt_bme  *(t1.lagerbestand_fg-1)*(-1)  AS NUMBER(38,5)) AS ds_markt_bestand_menge_ges
   ,CAST(t1.menge_lgbest_erp_qual_bme  *(t1.lagerbestand_fg-1)*(-1)  AS NUMBER(38,5)) AS ds_markt_bestand_menge_qual
   ,CAST(ds_markt_bestand_menge_frei  * t3.einstandspreis   AS NUMBER(38,5)) AS ds_markt_bestand_klep_frei
   ,CAST(ds_markt_bestand_menge_ges * t3.einstandspreis   AS NUMBER(38,5)) AS ds_markt_bestand_klep_ges
   ,CAST(ds_markt_bestand_menge_frei  * t3.ek_mep    AS NUMBER(38,5)) AS ds_markt_bestand_mep_frei
   ,CAST(ds_markt_bestand_menge_ges * t3.ek_mep    AS NUMBER(38,5)) AS ds_markt_bestand_mep_ges
   ,CAST(ds_markt_bestand_menge_frei  * t3.ek_netto    AS NUMBER(38,5)) AS ds_markt_bestand_ekn_frei
   ,CAST(ds_markt_bestand_menge_ges * t3.ek_netto    AS NUMBER(38,5)) AS ds_markt_bestand_ekn_ges
   ,CAST(ds_markt_bestand_menge_frei  * t3.ek_netto_bnk   AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_frei
   ,CAST(ds_markt_bestand_menge_ges * t3.ek_netto_bnk   AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_ges
   ,CAST(betrag_vk_netto_frei_bme  *(t1.lagerbestand_fg-1)*(-1)  AS NUMBER(38,5)) AS ds_markt_bestand_vkn_frei
   ,CAST(betrag_vk_netto_gesamt_bme  *(t1.lagerbestand_fg-1)*(-1)  AS NUMBER(38,5)) AS ds_markt_bestand_vkn_ges
   ,CAST(menge_abgang_bme   *(t1.lagerbestand_fg-1)*(-1)  AS NUMBER(38,5)) AS markt_verbrauch_menge
   ,CAST(markt_verbrauch_menge  * t3.einstandspreis   AS NUMBER(38,5)) AS markt_verbrauch_klep
   ,CAST(markt_verbrauch_menge  * t3.ek_mep    AS NUMBER(38,5)) AS markt_verbrauch_mep
   ,CAST(markt_verbrauch_menge  * t3.ek_netto    AS NUMBER(38,5)) AS markt_verbrauch_ekn
   ,CAST(markt_verbrauch_menge  * t3.ek_netto_bnk   AS NUMBER(38,5)) AS markt_verbrauch_ekn_bnk

   FROM dbp_view.v_art_bestand_vw_sum_2  t1_2
   /*INNER JOIN dbp_view.v_art_wup_ek_zu_per_2 t2
   ON     t1.art_id = t2.art_id
   AND t1.wup_id = t2.wup_id
   AND t1.mandant_id = t2.mandant_id
   AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
   -- 20100330 Filterung der IWT Betriebe
   AND t2.nb_id <> 99*/
   
   INNER JOIN dbp_view.v_art_gp_nm_zu_per_2 t2
   ON  t1.art_id = t2.art_id
   AND t1.wup_id = t2.wup_id
   AND t1.mandant_id = t2.mandant_id
   AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
   
   INNER JOIN dbp_view.v_art_gp_wup_zu_per_2 t3
   ON  t2.gp_id = t3.gp_id
   AND t2.art_id = t3.art_id
   AND t2.wup_id = t3.wup_id
   AND t2.mandant_id = t3.mandant_id
   AND t1.dat BETWEEN t3.dat_von AND t3.dat_bis
   
   WHERE t1.mandant_id = 1;