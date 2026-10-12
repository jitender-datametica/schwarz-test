create or replace view DBP_TRANS.MV_F_ANF_MARKT_BESTAND_ERP(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	STIMMIG_ID,
	DAT,
	WRG_ID,
	GP_ID,
	AN_MARKT_BESTAND_MENGE_FREI,
	AN_MARKT_BESTAND_MENGE_QUAL,
	AN_MARKT_BESTAND_MENGE_GES,
	AN_MARKT_BESTAND_EKN2_FREI,
	AN_MARKT_BESTAND_EKN2_QUAL,
	AN_MARKT_BESTAND_EKN2_GES,
	AN_MARKT_BESTAND_EKN4_FREI,
	AN_MARKT_BESTAND_EKN4_QUAL,
	AN_MARKT_BESTAND_EKN4_GES,
	AN_MARKT_BESTAND_VKN_FREI,
	AN_MARKT_BESTAND_VKN_QUAL,
	AN_MARKT_BESTAND_VKN_GES
) as
   
   
   

   SELECT

   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.art_id,
   v01.stimmig_id,
   v02.dat + 1 AS dat,
   v01.wrg_id,
   v01.gp_id,
   v01.ds_markt_bestand_menge_frei AS an_markt_bestand_menge_frei,
   v01.ds_markt_bestand_menge_qual AS an_markt_bestand_menge_qual,
   v01.ds_markt_bestand_menge_ges AS an_markt_bestand_menge_ges,
   v01.ds_markt_bestand_ekn2_frei AS an_markt_bestand_ekn2_frei,
   v01.ds_markt_bestand_ekn2_qual AS an_markt_bestand_ekn2_qual,
   v01.ds_markt_bestand_ekn2_ges AS an_markt_bestand_ekn2_ges,
   v01.ds_markt_bestand_ekn4_frei AS an_markt_bestand_ekn4_frei,
   v01.ds_markt_bestand_ekn4_qual AS an_markt_bestand_ekn4_qual,
   v01.ds_markt_bestand_ekn4_ges AS an_markt_bestand_ekn4_ges,
   v01.ds_markt_bestand_vkn_frei AS an_markt_bestand_vkn_frei,
   v01.ds_markt_bestand_vkn_qual AS an_markt_bestand_vkn_qual,
   v01.ds_markt_bestand_vkn_ges AS an_markt_bestand_vkn_ges

  FROM dbp_trans.mv_f_markt_bestand_erp_per v01

   JOIN dbp_view.v_tag v02
   ON v01.dat = v02.dat;