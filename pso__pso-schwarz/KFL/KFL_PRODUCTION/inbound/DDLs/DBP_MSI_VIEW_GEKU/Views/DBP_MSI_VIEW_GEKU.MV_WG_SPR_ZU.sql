CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WG_SPR_ZU
(
    wg_id
   ,arthiertyp_id
   ,mandant_id
   ,wg_bez
   ,wg_bez_cz
   ,wg_bez_pl
   ,wg_bez_sk
   ,wg_bez_hr
   ,wg_bez_ro
   ,wg_bez_bg
)
AS
--22.06.2022 twie: SPEC0145413 Sprachtabelle Warengruppe

SELECT

    v01.wg_id
   ,v01.arthiertyp_id
   ,v01.mandant_id
   ,MAX(CASE WHEN v01.spr_id =   22 THEN v01.wg_bez ELSE NULL END)  AS wg_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id =  124 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_pl
   ,MAX(CASE WHEN v01.spr_id =  108 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_bg

FROM dbp_view.v_wg_spr_zu v01

WHERE v01.arthiertyp_id = 2
AND v01.wg_id >= -3

GROUP BY 
 v01.wg_id
,v01.arthiertyp_id
,v01.mandant_id;