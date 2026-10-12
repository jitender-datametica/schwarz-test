CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_MSI_DRILL_UWG_ITEM_2

AS
SELECT
base.client_id
,base.adv_week_id
,CAST ( base.adv_week_id *100::INTEGER +  base.client_id AS INTEGER )  AS  adv_week_sid
,base.rltd_adv_week_id
,CAST ( ( COALESCE ( base.rltd_adv_week_id, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  )  AS  rltd_adv_week_sid
,base.item_grp_int_sid
,base.sub_item_grp_sid
,CAST ( ( COALESCE ( base.item_grp_int_sid, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  )  AS item_grp_int_mstr_sid
,CAST ( ( COALESCE ( base.sub_item_grp_sid, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  )  AS sub_item_grp_mstr_sid
,CAST( 1 AS INTEGER)  AS _count
/* Drill from itemgroup_2 WGI  ( or subitemgroup UWG )  to items  ( Artikel_2 )  */
,CASE WHEN base.sub_item_grp_sid <> -2  THEN
        pa.pa01_value
        || '<a style="color:#ffffff" title="Detailanzeige f&uuml;r'
        || ' Werbewoche '
        || adw.adv_week_descr
        || ' und UWG: '
        || TRIM (REPLACE (REPLACE (REPLACE (REPLACE ( sig.sub_item_grp_descr_int,'ü','&uuml;'),'ä','&auml;'),'ö','&ouml;'),'"','&apos;'))

|| '" HREF="mstrWeb'
/* ? */
|| CHR ( 63 )
/* PIT-30.10.10 Kategorien UWG Artikel_2   A50746BC433E0CE9BC647EA8B66469F5 */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa04_value
|| '&elementsPromptAnswers='

/* E  Land_2  (  Basic  )  = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
     pa.pa06_value || CAST (  base.client_id AS VARCHAR ( 12 ) ) || ','
   ELSE NULL END

/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
     pa.pa08_value || CAST(  CAST ( ( COALESCE ( base.adv_week_id, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  ) AS VARCHAR ( 12 )) || ','
ELSE NULL END

/* E Unterwarengruppe = ?! */
|| CASE WHEN pa.pa10_value IS NOT NULL THEN
  pa.pa10_value || CAST(  CAST ( ( COALESCE ( base.sub_item_grp_sid, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  ) AS VARCHAR ( 12 ))
ELSE NULL END

|| '" '
|| pa.pa03_value
|| '> '
|| pa.pa02_value
|| '</a></span>'

/* Drill from total of the itemgroup_2 WGI to all items of this itemgroup_2 WGI */
WHEN base.sub_item_grp_sid = -2 THEN
/* DEFAULT NULL VALUE */
pa.pa12_value
|| '<a style="color:#ffffff" title="Detailanzeige f&uuml;r'
|| ' Werbewoche '
|| adw.adv_week_descr
|| ' und alle UWG'

|| '" HREF="mstrWeb'
/* ? */
|| CHR ( 63 )
/* PIT-30.10.19 Kategorien UWG Artikel_2  ( Alle UWG )     7B27D2FD11E970A516860080EF25BEE9 */
|| 'evt=2048001&src=mstrWeb.2048001&documentID='
|| pa.pa14_value
|| '&elementsPromptAnswers='

/* E  Land_2  (  Basic  )  = ?! */
|| CASE WHEN pa.pa06_value IS NOT NULL THEN
  pa.pa06_value || CAST (  base.client_id AS VARCHAR ( 12 ) ) || ','
ELSE NULL END

/* E Werbewoche = ?! */
|| CASE WHEN pa.pa08_value IS NOT NULL THEN
  pa.pa08_value || CAST(  CAST ( ( COALESCE ( base.adv_week_id, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  ) AS VARCHAR ( 12 )) || ','
ELSE NULL END

/* E Unterwarengruppe = ?! */
|| CASE WHEN pa.pa10_value IS NOT NULL THEN
  pa.pa10_value || CAST(  CAST ( ( COALESCE ( base.sub_item_grp_sid, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  ) AS VARCHAR ( 12 )) || ','
ELSE NULL END

/* E Warengruppe International = ?! */
|| CASE WHEN pa.pa11_value IS NOT NULL THEN
  pa.pa11_value || CAST(  CAST ( ( COALESCE ( base.item_grp_int_sid, -1::INTEGER )  *100::INTEGER ) +  base.client_id AS INTEGER  ) AS VARCHAR ( 12 ))
ELSE NULL END

|| '" '
|| pa.pa03_value
|| '> '
|| pa.pa02_value
|| '</a></span>'

ELSE
NULL
END  AS drill_to_item_link_html
FROM p_lew_mart_pit_onprem.v_pit_base_category_all_2 AS base

INNER JOIN p_lew_mart_pit_onprem.v_pit_itemgroup_international_2 AS igi
ON  base.client_id           = igi.client_id
AND base.item_grp_int_sid    = igi.item_grp_int_sid

INNER JOIN p_lew_mart_pit_onprem.v_pit_subitemgroup_2 AS sig
ON  sig.client_id            = base.client_id
AND sig.sub_item_grp_sid     = base.sub_item_grp_sid

INNER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS adw
ON  base.client_id   = adw.client_id
AND base.adv_week_id = adw.adv_week_id

INNER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS rltd_adw
ON  base.client_id        = rltd_adw.client_id
AND base.rltd_adv_week_id = rltd_adw.adv_week_id

/* CROSS JOIN Parameter Values */
CROSS JOIN
 (SELECT
MAX ( CASE WHEN param_id =  1 THEN COALESCE ( param_value,'<!-- ERROR SPAN Tag_2 -->') END )           AS pa01_value
,MAX ( CASE WHEN param_id =  2 THEN COALESCE ( param_value,'<!-- ERROR IMG Tag_2  -->') END )           AS pa02_value
,MAX ( CASE WHEN param_id =  3 THEN COALESCE ( param_value,'<!-- ERROR Target Attribute -->') END )   AS pa03_value
,MAX ( CASE WHEN param_id =  4 THEN param_value END )                                               AS pa04_value
,MAX ( CASE WHEN param_id =  5 THEN param_value END )                                               AS pa05_value
,MAX ( CASE WHEN param_id =  6 THEN param_value END )                                               AS pa06_value
,MAX ( CASE WHEN param_id =  7 THEN COALESCE ( param_value,'N/A')END )                                AS pa07_value
,MAX ( CASE WHEN param_id =  8 THEN param_value END )                                               AS pa08_value
,MAX ( CASE WHEN param_id =  9 THEN param_value END )                                               AS pa09_value
,MAX ( CASE WHEN param_id = 10 THEN param_value END )                                               AS pa10_value
,MAX ( CASE WHEN param_id = 11 THEN param_value END )                                               AS pa11_value
,MAX ( CASE WHEN param_id = 12 THEN COALESCE ( param_value,'N/A') END )                               AS pa12_value
,MAX ( CASE WHEN param_id = 13 THEN param_value END )                                               AS pa13_value
,MAX ( CASE WHEN param_id = 14 THEN param_value END )                                               AS pa14_value
,MAX ( CASE WHEN param_id = 15 THEN COALESCE ( param_value,'<!-- ERROR IMG Tag_2  -->') END )           AS pa15_value
,MAX ( CASE WHEN param_id = 16 THEN param_value END )                                               AS pa16_value
,MAX ( CASE WHEN param_id = 17 THEN param_value END )                                               AS pa17_value
,MAX ( CASE WHEN param_id = 18 THEN param_value END )                                               AS pa18_value
,MAX ( CASE WHEN param_id = 19 THEN param_value END )                                               AS pa19_value
,MAX ( CASE WHEN param_id = 20 THEN param_value END )                                               AS pa20_value
,MAX ( CASE WHEN param_id = 21 THEN param_value END )                                               AS pa21_value
,MAX ( CASE WHEN param_id = 22 THEN param_value END )                                               AS pa22_value
,MAX ( CASE WHEN param_id = 23 THEN param_value END )                                               AS pa23_value
,MAX ( CASE WHEN param_id = 26 THEN param_value END )                                               AS pa26_value
FROM p_lew_mart_pit_onprem.v_pit_param_2
)  AS pa

WHERE base.advert_items_cnt > 0
/* AND   base.item_grp_int_sid <> -2      In this 2. drill level, we include the overall sum total to store the total on the 1. drill level (WGI) as well in the same cube. */

/* Keeping only the nearest related advertising week  ( no related week on item_2 level needed )  */
AND base.nearest_rltd_adv_week_fg = 1;