INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        sup_sid,
        sup_name,
        legal_name,
        vat_nr,
        sup_status_cd,
        sup_status_descr,
        iso_country_cd,
        country_name,
        city_name,
        district_name,
        zip,
        street_name,
        house_nr,
        lon,
        lat,
        dwh_valid_fg,
        dwh_mapping_tmsp,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename,
        deleted_fg
)
SELECT
        s.sup_sid
        ,coalesce (org.org_name,'Unbekannt') as sup_name
        ,coalesce (org.legal_name, 'Unbekannt') as legal_name
        ,coalesce (org.vat_nr,'-1') as vat_nr
        ,'@' as sup_status_cd
        ,'Unbekannt' as sup_status_descr
        ,coalesce (c.iso_country_cd, '@') as iso_country_cd
        ,coalesce (c.country_name, 'unbekannt') as country_name
        ,'Unbekannt' as city_name
        ,'Unbekannt' as district_name
        ,1 as zip
        ,'Unbekannt' as street_name
        ,NULL house_nr
        ,NULL lon
        ,NULL lat
        ,s.dwh_valid_fg
        ,s.dwh_valid_from_tmsp as dwh_mapping_tmsp
        ,${LOAD_ID} dwh_load_id
        ,s.dwh_node_cd
        ,0 as tf_error_fg
        ,'' as error_descr
        ,0 as record_id
        ,'t_product_supplier_1' as filename
        ,0 as deleted_fg
from core_rel.t_product_supplier_1 s
left join CORE_REL.T_ORGANIZATION_1 org ON s.sup_sid = org.org_sid and org.dwh_valid_fg = 1 and org.is_sup_fg = 1 and org.org_type_cd = 'COMPANY'
left join CORE_REL.T_COUNTRY_1 c ON s.int_org_sid = c.country_sid and c.dwh_valid_fg = 1
where s.dwh_valid_fg = 1
QUALIFY ROW_NUMBER() over (partition by s.sup_sid order by s.dwh_valid_from_tmsp asc) = 1
;
