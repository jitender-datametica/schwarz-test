create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CS.V_BW_RETAIL_EJR_WRITEOFF_PV_CUM_BY_2(
	CLIENT_ID,
	""LAND_2 O08 ISO-CODE"",
	""WG I05 MIS WG ID"",
	""UWG I04 MIS UWG ID"",
	""ARTIKELFAMILIE GRUPPIERT I04 ARTIKELFAMILIENNUMMER"",
	""ARTIKELART (HIST) HI08 ID"",
	""WAEHRUNG X02 BEZEICHNUNG"",
	""MONAT_2 T05 ID"",
	""UMSATZ EJR AUFGEL."",
	""ABSCHRIFTEN_2 GESAMT AUFGEL."",
	""PREISVERAENDERUNG AUFGEL.""
) as
SELECT	
    wh.client_id                      AS CLIENT_ID
  , wh.country_iso_cd                 AS ""LAND_2 O08 ISO-CODE""
  , sig.itemgroup_int_id              AS ""WG I05 MIS WG ID""
	, sig.subitemgroup_id               AS ""UWG I04 MIS UWG ID""
	, ifg.family_cd                     AS ""ARTIKELFAMILIE GRUPPIERT I04 ARTIKELFAMILIENNUMMER""
	, (CASE WHEN blt.buying_list_type_id IS NULL THEN -1 ELSE blt.buying_list_type_id END)    AS ""ARTIKELART (HIST) HI08 ID""
	, COALESCE(ejr.currency_iso_cd, prch.currency_iso_cd, wroff.currency_iso_cd)              AS ""WAEHRUNG X02 BEZEICHNUNG""
	, cmd.cy_month                      AS ""Monat_2 T05 ID""
	, SUM(ejr.val_ejr_cum_by)           AS ""UMSATZ EJR AUFGEL.""  --M1401
  , SUM(wroff.val_writeoff_cum_by)    AS ""ABSCHRIFTEN_2 GESAMT AUFGEL.""   --M1201BNL
	, SUM(prch.val_pricechange_cum_by)  AS ""PREISVERAENDERUNG AUFGEL.""   --M1102PVS
FROM	p_lew_mart_cs.v_bw_retail_ejr_cum_by_2	                              AS ejr
FULL OUTER JOIN	p_lew_mart_cs.v_bw_pricechange_cum_by_2	                    AS prch
  ON 	ejr.aspect_id = prch.aspect_id
  AND ejr.buying_list_type_id = prch.buying_list_type_id 
  AND ejr.client_id = prch.client_id 
  AND ejr.currency_iso_cd = prch.currency_iso_cd 
  AND ejr.curr_tot_id = prch.curr_tot_id 
  AND ejr.cy_month = prch.cy_month 
  AND ejr.item_familygroup_id = prch.item_familygroup_id 
  AND ejr.subitemgroup_id = prch.subitemgroup_id 
  AND ejr.subitemgroup_id0 = prch.subitemgroup_id0 
  AND ejr.wh_id = prch.wh_id
FULL OUTER JOIN	p_lew_mart_cs.v_bw_writeoff_cum_by_2	                      AS wroff
  ON 	COALESCE(ejr.aspect_id, prch.aspect_id) = wroff.aspect_id
  AND COALESCE(ejr.buying_list_type_id, prch.buying_list_type_id) = wroff.buying_list_type_id 
  AND COALESCE(ejr.client_id, prch.client_id) = wroff.client_id 
  AND COALESCE(ejr.currency_iso_cd, prch.currency_iso_cd) = wroff.currency_iso_cd 
  AND COALESCE(ejr.curr_tot_id, prch.curr_tot_id) = wroff.curr_tot_id 
  AND COALESCE(ejr.cy_month, prch.cy_month) = wroff.cy_month 
  AND COALESCE(ejr.item_familygroup_id, prch.item_familygroup_id) = wroff.item_familygroup_id 
  AND COALESCE(ejr.subitemgroup_id, prch.subitemgroup_id) = wroff.subitemgroup_id 
  AND COALESCE(ejr.subitemgroup_id0, prch.subitemgroup_id0) = wroff.subitemgroup_id0 
  AND COALESCE(ejr.wh_id, prch.wh_id) = wroff.wh_id
INNER JOIN	p_lew_mart_msi_ac.v_org_wh_merge_2	                            AS wh
  ON 	COALESCE(ejr.aspect_id, prch.aspect_id, wroff.aspect_id) = wh.aspect_id 
  AND COALESCE(ejr.client_id, prch.client_id, wroff.client_id) = wh.client_id 
  AND COALESCE(ejr.wh_id, prch.wh_id, wroff.wh_id) = wh.wh_id
INNER JOIN	p_lew_mart_msi_ac.v_itm_subitemgroup_2	                        AS sig
  ON 	COALESCE(ejr.subitemgroup_id, prch.subitemgroup_id, wroff.subitemgroup_id) = sig.subitemgroup_id
INNER JOIN	p_lew_mart_msi_ac.v_ref_itm_list_type_buylist_2	                AS blt
  ON 	COALESCE(ejr.buying_list_type_id, prch.buying_list_type_id, wroff.buying_list_type_id) = (CASE WHEN blt.buying_list_type_id IS NULL THEN -1 ELSE blt.buying_list_type_id END)
INNER JOIN	p_lew_mart_msi_ac.v_itm_familygroup_int_2	                      AS ifg
  ON 	COALESCE(ejr.item_familygroup_id, prch.item_familygroup_id, wroff.item_familygroup_id) = ifg.family_cd 
  AND COALESCE(ejr.subitemgroup_id0, prch.subitemgroup_id0, wroff.subitemgroup_id0) = ifg.subitemgroup_id
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc_2	                          AS cmd
  ON 	COALESCE(ejr.cy_month, prch.cy_month, wroff.cy_month) = cmd.cy_month

GROUP BY	
	  wh.client_id
	, wh.country_iso_cd
  , sig.itemgroup_int_id
	, sig.subitemgroup_id
	, ifg.family_cd
	, (CASE WHEN blt.buying_list_type_id IS NULL THEN -1 ELSE blt.buying_list_type_id END)
	, COALESCE(ejr.currency_iso_cd, prch.currency_iso_cd, wroff.currency_iso_cd)
	, cmd.cy_month
;
