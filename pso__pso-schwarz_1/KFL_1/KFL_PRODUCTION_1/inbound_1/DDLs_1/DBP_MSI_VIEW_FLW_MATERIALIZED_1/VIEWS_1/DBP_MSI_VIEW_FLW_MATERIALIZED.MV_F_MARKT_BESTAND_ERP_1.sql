create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_MARKT_BESTAND_ERP_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	STIMMIG_ID,
	DAT,
	WRG_ID,
	DS_MARKT_BESTAND_MENGE_FREI,
	DS_MARKT_BESTAND_MENGE_QUAL,
	DS_MARKT_BESTAND_MENGE_GES,
	DS_MARKT_BESTAND_EKN_FREI,
	DS_MARKT_BESTAND_EKN_QUAL,
	DS_MARKT_BESTAND_EKN_GES,
	DS_MARKT_BESTAND_EKN_BNK_FREI,
	DS_MARKT_BESTAND_EKN_BNK_QUAL,
	DS_MARKT_BESTAND_EKN_BNK_GES,
	DS_MARKT_BESTAND_VKN_FREI,
	DS_MARKT_BESTAND_VKN_QUAL,
	DS_MARKT_BESTAND_VKN_GES
) as
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.art_id, v01.relevant_fg AS stimmig_id, v01.dat, v02.wrg_id, v01.menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei, v01.menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual, CAST(v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_qual_bme AS NUMBER(38,5)) AS ds_markt_bestand_menge_ges, CAST(ds_markt_bestand_menge_frei * v02.ek_netto AS NUMBER(38,5)) AS ds_markt_bestand_ekn_frei, CAST(ds_markt_bestand_menge_qual * v02.ek_netto AS NUMBER(38,5)) AS ds_markt_bestand_ekn_qual, CAST(ds_markt_bestand_menge_ges * v02.ek_netto AS NUMBER(38,5)) AS ds_markt_bestand_ekn_ges, CAST(ds_markt_bestand_menge_frei * v02.ek_netto_bnk AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_frei, CAST(ds_markt_bestand_menge_qual * v02.ek_netto_bnk AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_qual, CAST(ds_markt_bestand_menge_ges * v02.ek_netto_bnk AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_ges, CAST(ds_markt_bestand_menge_frei * v02.vk_netto AS NUMBER(38,5)) AS ds_markt_bestand_vkn_frei, CAST(ds_markt_bestand_menge_qual * v02.vk_netto AS NUMBER(38,5)) AS ds_markt_bestand_vkn_qual, CAST(ds_markt_bestand_menge_ges * v02.vk_netto AS NUMBER(38,5)) AS ds_markt_bestand_vkn_ges

   FROM dbp_view.v_marktbestand_erp_1 v01

   JOIN dbp_view.v_marktbestand_erp_zu_1 v02
   ON v01.bestand_id = v02.bestand_id
   AND v01.mandant_id = v02.mandant_id

   WHERE v01.mandant_id =1;