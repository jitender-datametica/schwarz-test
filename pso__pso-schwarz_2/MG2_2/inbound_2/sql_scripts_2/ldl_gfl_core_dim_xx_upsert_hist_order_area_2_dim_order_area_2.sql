INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        order_area_nr,
        country_org_sid,
        country_org_cd,
        order_area_descr,
        order_area_descr_en,
        order_area_descr_de,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename
)
SELECT 
        order_area_nr, 
        int_org_sid country_org_sid,
        country_org_cd,
        order_area_descr,
        order_area_descr_en,
        order_area_descr_de,
        ${LOAD_ID} dwh_load_id,
        dwh_node_cd,
        0 tf_error_fg,
        '' error_descr,
        0 record_id,
        'core_rel.t_order_area_2' filename
FROM
   (
     SELECT 
            oa.order_area_nr, 
            oa.int_org_sid,
            intorg.country_org_cd,
            oa.dwh_node_cd dwh_node_cd,
            MAX (CASE WHEN lang_cd ='DE' THEN order_area_descr ELSE '' END) AS order_area_descr,
            MAX (CASE WHEN lang_cd ='EN' THEN order_area_descr ELSE '' END) AS order_area_descr_en,
            MAX (CASE WHEN lang_cd ='DE' THEN order_area_descr ELSE '' END) AS order_area_descr_de,
     FROM core_rel.t_order_area_2 oa
     JOIN core_rel.t_internal_organization_2 intorg ON oa.int_org_sid = intorg.int_org_sid AND intorg.dwh_valid_fg
     GROUP BY 1,2,3,4
    )

union all 

select --select all order_area numbers from product which are missing in the core_rel.t_order_area_2 table
d.order_area_nr
,d.int_org_sid as country_org_sid
,p.country_org_cd
,'unbekannt' as order_area_descr
,'unknown' as order_area_descr_en
,'unbekannt' as order_area_descr_de
,${LOAD_ID} dwh_load_id
,'WAWI' as dwh_node_cd
,0 tf_error_fg
,'' error_descr
,0 record_id
,'core_rel.t_product_order_area_2' filename
from (
      select p.order_area_nr 
             ,p.int_org_sid 
      from core_rel.t_product_order_area_2 p
      left join core_rel.t_order_area_2 oa on p.order_area_nr = oa.order_area_nr and p.int_org_sid = oa.int_org_sid
      where p.dwh_valid_fg = 1 and oa.order_area_nr is null
      group by p.int_org_sid, p.order_area_nr
      ) as d
left join core_rel.t_internal_organization_2 p on d.int_org_sid = p.int_org_sid
where p.dwh_valid_fg = 1 and p.int_org_type_cd = 'COMPANY'

union all

SELECT --insert generell dummy_2
'@' as order_area_nr, 
-1 as country_org_sid,
'@' as country_org_cd,
'@' as order_area_descr,
'@' as order_area_descr_en,
'@' as order_area_descr_de,
-1 as dwh_load_id,
'DUMMY_2' as dwh_node_cd,
0 tf_error_fg,
'' error_descr,
0 record_id,
'DUMMY_2' filename
;

INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        order_area_nr,
        country_org_sid,
        country_org_cd,
        order_area_descr,
        order_area_descr_en,
        order_area_descr_de,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename
)
SELECT --insert dummys for each country_2
a.order_area_nr
,a.country_org_sid
,p.country_org_cd
,'@' as order_area_descr
,'@' as order_area_descr_en
,'@' as order_area_descr_de
,${LOAD_ID} dwh_load_id
,'DUMMY_2' as dwh_node_cd
,0 tf_error_fg
,'' error_descr
,0 record_id
,'DUMMY_2' filename
from (
      select distinct
      p.ORDER_AREA_NR 
      ,p.country_org_sid 
      from CORE_DIM.T_DIM_LOCAL_PRODUCT_2 p
      left join ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} pg on p.ORDER_AREA_NR = pg.ORDER_AREA_NR and p.country_org_sid = pg.country_org_sid
      where pg.ORDER_AREA_NR is null
      ) a
left join core_rel.t_internal_organization_2 p on a.country_org_sid = p.int_org_sid
where p.dwh_valid_fg = 1 and p.int_org_type_cd = 'COMPANY'
;
