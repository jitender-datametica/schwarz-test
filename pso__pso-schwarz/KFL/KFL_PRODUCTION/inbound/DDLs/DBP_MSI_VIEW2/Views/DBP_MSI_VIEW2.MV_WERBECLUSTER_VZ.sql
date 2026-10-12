create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_WERBECLUSTER_VZ(
	MANDANT_ID,
	KJWO,
	VZ_WUP_ID,
	VZ_NB_ID,
	WG_ID,
	ART_ID,
	FAKTURA_MENGE_SA_WW,
	FAKTURA_MENGE_SA_1VW,
	FAKTURA_MENGE_SA_WW_VW,
	FAKTURA_MENGE_AF_6VW,
	WERBECLUSTER,
	FAKTURA_MENGE_AF_1FW,
	NORMALCLUSTER_1FW,
	FAKTURA_MENGE_AF_2FW,
	NORMALCLUSTER_2FW,
	FAKTURA_MENGE_AF_3FW,
	NORMALCLUSTER_3FW,
	FAKTURA_MENGE_SA_WW_WG,
	FAKTURA_MENGE_SA_1VW_WG,
	FAKTURA_MENGE_SA_WW_1VW_WG,
	FAKTURA_MENGE_AF_6VW_WG,
	WERBECLUSTER_WG,
	FAKTURA_MENGE_AF_1FW_WG,
	NORMALCLUSTER_1FW_WG,
	FAKTURA_MENGE_AF_2FW_WG,
	NORMALCLUSTER_2FW_WG,
	FAKTURA_MENGE_AF_3FW_WG,
	NORMALCLUSTER_3FW_WG,
	MAX_WERBECLUSTER,
	MAX_WERBECLUSTER_NEW,
	MIN_WERBECLUSTER,
	MIN_WERBECLUSTER_NEW
) as
   SELECT 
   mandant_id,
   kjwo,
   wup_id,
   nb_id,
   wg_id,
   art_id,
   faktura_menge_sa_ww,
   faktura_menge_sa_1vw,
   faktura_menge_sa_ww_vw,
   faktura_menge_af_6vw,
   werbecluster,
   faktura_menge_af_1fw,
   normalcluster_1fw,
   faktura_menge_af_2fw,
   normalcluster_2fw,
   faktura_menge_af_3fw,
   normalcluster_3fw,
   faktura_menge_sa_ww_wg,
   faktura_menge_sa_1vw_wg,
   faktura_menge_sa_ww_1vw_wg,
   faktura_menge_af_6vw_wg,
   werbecluster_wg,
   faktura_menge_af_1fw_wg,
   normalcluster_1fw_wg,
   faktura_menge_af_2fw_wg,
   normalcluster_2fw_wg,
   faktura_menge_af_3fw_wg,
   normalcluster_3fw_wg,
   max_werbecluster,
   max_werbecluster_new,
   min_werbecluster,
   min_werbecluster_new
   FROM
   (
   SELECT mandant_id,
   kjwo,
   wup_id,
   nb_id,
   wg_id,
   art_id,
   faktura_menge_sa_ww,
   faktura_menge_sa_1vw,
   faktura_menge_sa_ww_vw,
   faktura_menge_af_6vw,
   werbecluster,
   faktura_menge_af_1fw,
   normalcluster_1fw,
   faktura_menge_af_2fw,
   normalcluster_2fw,
   faktura_menge_af_3fw,
   normalcluster_3fw,
   faktura_menge_sa_ww_wg,
   faktura_menge_sa_1vw_wg,
   faktura_menge_sa_ww_1vw_wg,
   faktura_menge_af_6vw_wg,
   werbecluster_wg,
   faktura_menge_af_1fw_wg,
   normalcluster_1fw_wg,
   faktura_menge_af_2fw_wg,
   normalcluster_2fw_wg,
   faktura_menge_af_3fw_wg,
   normalcluster_3fw_wg,
   MAX(werbecluster) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS max_werbecluster,
   max_werbecluster_new,
   MIN(werbecluster) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS min_werbecluster,
   min_werbecluster_new
   FROM
   (
   SELECT
   mandant_id,
   kjwo,
   wup_id,
   nb_id,
   wg_id,
   art_id,
   --- auf Artikelebene ----------------------------------------------------------------------------------------
   faktura_menge_sa_ww
   ,
   faktura_menge_sa_1vw,
   CAST(faktura_menge_sa_ww + faktura_menge_sa_1vw AS DECIMAL(18,4)) AS faktura_menge_sa_ww_vw,
   faktura_menge_af_6vw,

   CASE WHEN faktura_menge_af_6vw > 0 THEN faktura_menge_sa_ww_vw / faktura_menge_af_6vw END AS werbecluster,

   MAX(CASE WHEN faktura_menge_af_6vw > 0 THEN faktura_menge_sa_ww_vw / faktura_menge_af_6vw END) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS max_werbecluster_new,
   MIN(CASE WHEN faktura_menge_af_6vw > 0 THEN faktura_menge_sa_ww_vw / faktura_menge_af_6vw END) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS min_werbecluster_new,

   --- 1. Folgewerbewoche auf Artikel Ebene ---
   faktura_menge_af_1fw
   ,
   CASE WHEN faktura_menge_af_6vw > 0 THEN CAST(faktura_menge_af_1fw AS DECIMAL(18,4)) / faktura_menge_af_6vw END AS normalcluster_1fw,
   --- 2. Folgewerbewoche auf Artikel Ebene ---
   faktura_menge_af_2fw
   ,
   CASE WHEN faktura_menge_af_6vw > 0 THEN CAST(faktura_menge_af_2fw AS DECIMAL(18,4)) / faktura_menge_af_6vw END AS normalcluster_2fw,
   --- 3. Folgewerbewoche auf Artikel Ebene ---
   faktura_menge_af_3fw
   ,
   CASE WHEN faktura_menge_af_6vw > 0 THEN CAST(faktura_menge_af_3fw AS DECIMAL(18,4)) / faktura_menge_af_6vw END AS normalcluster_3fw,

   --- auf WG Ebene --------------------------------------------------------------------------------------------
   SUM(faktura_menge_sa_ww)  OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS faktura_menge_sa_ww_wg,
   SUM(faktura_menge_sa_1vw) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS faktura_menge_sa_1vw_wg,
   faktura_menge_sa_ww_wg + faktura_menge_sa_1vw_wg AS faktura_menge_sa_ww_1vw_wg,
   SUM(faktura_menge_af_6vw) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS faktura_menge_af_6vw_wg,
   CASE WHEN faktura_menge_af_6vw_wg > 0 THEN CAST(faktura_menge_sa_ww_1vw_wg AS DECIMAL(18,4)) / faktura_menge_af_6vw_wg END AS werbecluster_wg,

   --- 1. Folgewerbewoche auf WG Ebene ---
   SUM(faktura_menge_af_1fw) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS faktura_menge_af_1fw_wg,
   CASE WHEN faktura_menge_af_6vw_wg > 0 THEN CAST(faktura_menge_af_1fw_wg AS DECIMAL(18,4)) / faktura_menge_af_6vw_wg  END AS normalcluster_1fw_wg,
   --- 2. Folgewerbewoche auf WG Ebene ---
   SUM(faktura_menge_af_2fw) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS faktura_menge_af_2fw_wg,
   CASE WHEN faktura_menge_af_6vw_wg > 0 THEN CAST(faktura_menge_af_2fw_wg AS DECIMAL(18,4)) / faktura_menge_af_6vw_wg END AS normalcluster_2fw_wg,
   --- 3. Folgewerbewoche auf WG Ebene ---
   SUM(faktura_menge_af_3fw) OVER (PARTITION BY mandant_id,kjwo,wup_id,wg_id) AS faktura_menge_af_3fw_wg,
   CASE WHEN faktura_menge_af_6vw_wg > 0 THEN CAST(faktura_menge_af_3fw_wg AS DECIMAL(18,4)) / faktura_menge_af_6vw_wg END AS normalcluster_3fw_wg

   FROM dbp_view.v_besch_faktura_werbecluster

   ) V11
   ) V12
   ;
