CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_BLOCK_WB
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,muki_block_wb_id
,muki_block_wb_kl_id_lang
,muki_block_wb_kl_art_id
,muki_block_wb_bez
,muki_block_wb_bez_de
,muki_block_wb_bez_cz
,muki_block_wb_bez_sk
,muki_block_wb_bez_hr
,muki_block_wb_bez_pl
,muki_block_wb_bez_ro
,muki_block_wb_bez_bg
,muki_block_kz_wb_id
)

AS
SELECT
 v01.mandant_id
,v01.art_id AS muki_block_wb_id
,LPAD (v01.kl_art_id, 8,0) AS muki_block_wb_kl_id_lang
,v01.kl_art_id AS muki_block_wb_kl_art_id
,COALESCE(MAX(CASE WHEN v02.spr_id = 22  THEN v02.art_bez END), 'N/A')  AS muki_block_wb_bez
,COALESCE(MAX(CASE WHEN v02.spr_id = 22  THEN v02.art_bez END), 'N/A')  AS muki_block_wb_bez_de
,COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.art_bez END), muki_block_wb_bez_de)  AS muki_block_wb_bez_cz
,COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.art_bez END), muki_block_wb_bez_de)  AS muki_block_wb_bez_sk
,COALESCE(MAX(CASE WHEN v02.spr_id = 65  THEN v02.art_bez END), muki_block_wb_bez_de)  AS muki_block_wb_bez_hr
,COALESCE(MAX(CASE WHEN v02.spr_id = 90  THEN v02.art_bez END), muki_block_wb_bez_de)  AS muki_block_wb_bez_pl
,COALESCE(MAX(CASE WHEN v02.spr_id = 95  THEN v02.art_bez END), muki_block_wb_bez_de)  AS muki_block_wb_bez_ro
,COALESCE(MAX(CASE WHEN v02.spr_id = 18  THEN v02.art_bez END), muki_block_wb_bez_de)  AS muki_block_wb_bez_bg
,CASE WHEN (v01.mutter_wb_id IS NULL) THEN 'W' ELSE 'M' END AS muki_block_kz_wb_id

FROM dbp_view.v_art v01

JOIN dbp_view.v_art_spr_zu v02
ON v01.art_id=v02.art_id
AND v01.mandant_id=v02.mandant_id

WHERE v01.mandant_id <> 1
AND (v01.mutter_wb_id IS NULL OR v01.mutter_wb_id = v01.art_id)
AND v01.dat_bis = '9999-12-31'

GROUP BY
 v01.mandant_id
,v01.art_id
,v01.kl_art_id
,v01.mutter_wb_id;