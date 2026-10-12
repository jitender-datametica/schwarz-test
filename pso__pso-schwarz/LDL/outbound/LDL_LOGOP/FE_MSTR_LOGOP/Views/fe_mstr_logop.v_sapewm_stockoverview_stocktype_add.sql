/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_stockoverview_stocktype_add
Description		|	SAP EWM Stock Overview - view with additional columns
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_stocktype_add (client_id
OPTIONS(description='Client ID (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), strg_bin
OPTIONS(description='Storage bin'), strg_type OPTIONS(description='Storage type'), strg_bin_aisle
OPTIONS(description='Storage bin aisle'), dwh_valid_from OPTIONS(description='Valid from date (PK)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), hu_ident
OPTIONS(description='Handling unit ID (PK)'), zz_hu_type OPTIONS(description='Handling unit type'), sorted_non_food_flg
OPTIONS(description='Sorted non-food flag'), pair_bracket OPTIONS(description='Pair bracket'), sys_pal
OPTIONS(description='System pallet'), prod_desc_fg OPTIONS(description='Product description Flag'), paci
OPTIONS(description='Putaway control indicator (Einlagersteuerkennzeichen)'), hu_epa
OPTIONS(description='Calculated EPA of handling unit (Europalettenaequivalente)'), assort_area_id
OPTIONS(description='Identified assortment area'), hu_type_ep
OPTIONS(description='Identified handling unit type for EP'), hu_type_ep_sp
OPTIONS(description='Identified handling unit type for EP with SP'), hu_type_single_dd
OPTIONS(description='Identified handling unit type for DD single'), hu_type_coupled_dd
OPTIONS(description='Identified handling unit type for DD coupled')) AS WITH STRGBINPHYSTK AS (SELECT DISTINCT V01.client_id
   ,
   V01.wh_id,
   V01.lgpla,
   V01.huident,
   V01.logpos,
   IF(STARTS_WITH(V02.maktx, 'NFBC'), 1, 0) AS prod_desc_fg,
   V02.put_stra AS paci,
   V01.dwh_valid_from
  FROM ldl_logop_data.t_sapewm_physicalstock AS V01
   LEFT JOIN ldl_logop_data.t_sapewm_warehouseattribute AS V02 ON V01.client_id = V02.client_id AND V01.wh_id = V02.wh_id
        AND V01.matnr = V02.matnr AND CURRENT_DATE BETWEEN V02.dwh_valid_from AND V02.dwh_valid_to
  WHERE CURRENT_DATE BETWEEN V01.dwh_valid_from AND V01.dwh_valid_to) (SELECT S.client_id,
   S.wh_id,
   S.lgpla AS strg_bin,
   S.lgtyp AS strg_type,
   S.aisle AS strg_bin_aisle,
   S.dwh_valid_from,
   S.dwh_created,
   S.dwh_updated,
   H.huident AS hu_ident,
   H.zz_hutyp_org AS zz_hu_type,
   H.zz_hu_sorted AS sorted_non_food_flg,
   H.zz_pair_brack AS pair_bracket,
   H.zz_sys_pal AS sys_pal,
   w.prod_desc_fg,
   w.paci,
    CASE
    WHEN H.zz_pair_brack = 0
    THEN 1
    WHEN H.zz_pair_brack = 2
    THEN 1
    WHEN H.zz_pair_brack = 1
    THEN 0.5
    ELSE NULL
    END AS hu_epa,
    CASE
    WHEN w.paci IN ('I100', 'I110')
    THEN 1
    WHEN S.client_id <> 23 AND w.paci = 'I120' OR S.client_id = 23 AND w.paci = 'I110'
    THEN 2
    WHEN w.paci IN ('I200', 'I201')
    THEN 3
    WHEN w.prod_desc_fg = 1
    THEN 4
    WHEN w.paci = 'I300' AND H.zz_hu_sorted = 'X'
    THEN 5
    WHEN w.paci = 'I300' AND IFNULL(H.zz_hu_sorted, '') <> 'X'
    THEN 6
    WHEN STARTS_WITH(H.huident, '92')
    THEN 7
    WHEN STARTS_WITH(H.huident, '94')
    THEN 8
    WHEN STARTS_WITH(H.huident, '96')
    THEN 9
    WHEN w.paci = 'I500'
    THEN 10
    WHEN w.paci = 'I800'
    THEN 11
    ELSE NULL
    END AS assort_area_id,
   (STARTS_WITH(H.zz_hutyp_org, 'EP')) IS TRUE AS hu_type_ep,
   ((STARTS_WITH(H.zz_hutyp_org, 'EP') AND H.zz_sys_pal = 2)) IS TRUE AS hu_type_ep_sp,
   ((STARTS_WITH(H.zz_hutyp_org, 'DD') AND H.zz_pair_brack = 1)) IS TRUE AS hu_type_single_dd,
   ((STARTS_WITH(H.zz_hutyp_org, 'DD') AND H.zz_pair_brack = 2)) IS TRUE AS hu_type_coupled_dd
  FROM ldl_logop_data.t_sapewm_storagebin AS S
   LEFT JOIN ldl_logop_data.t_sapewm_handlingunitstock AS H ON S.client_id = H.client_id AND S.wh_id = H.wh_id AND S.lgpla
       = H.lgpla AND CURRENT_DATE = DATE(H.dwh_updated)
   LEFT JOIN STRGBINPHYSTK AS w ON H.client_id = w.client_id AND S.wh_id = H.wh_id AND H.lgpla = w.lgpla AND H.huident =
     w.huident
  WHERE CURRENT_DATE BETWEEN S.dwh_valid_from AND S.dwh_valid_to
   AND CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to
   AND ((S.client_id, S.wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96), (18, 4), (13, 60)) AND S.lgtyp = '8141' OR (S.client_id
        , S.wh_id) = (23, 18) AND S.lgtyp = '8241')
   AND (NOT STARTS_WITH(H.huident, '92') OR H.created_by = 'RFC-MFS')
   AND NOT H.deleted_fg);