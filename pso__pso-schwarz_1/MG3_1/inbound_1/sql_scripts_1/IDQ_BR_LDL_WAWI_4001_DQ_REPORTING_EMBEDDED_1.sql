WITH CTE_BASE AS
(
select 

    p_lew_core.t_item.src_orig_item_nr,
    p_lew_core. t_item.src_case_size,
    p_lew_core.t_item.client_id as client,
    p_lew_core.t_wawi_itm_item.orig_item_nr_int,
    p_lew_core.t_wawi_itm_item.brand_name,
    p_lew_core.t_wawi_itm_item.subitemgroup_id,
    p_lew_core.t_wawi_itm_item.case_size,
    p_lew_core.t_wawi_itm_item.case_size_dec,
    p_lew_core.t_wawi_itm_item.unitsize,
    p_lew_core.t_wawi_itm_item.packing,
    p_lew_core.t_wawi_itm_item.buying_list_type_id,
    p_lew_core.t_wawi_itm_item.weight_item_fg,
    p_lew_core.t_wawi_itm_item.scale_fg,
    p_lew_core.t_item_relevance_classification.*

from
p_lew_core.t_item_1 
inner join p_lew_core.t_item_relevance_classification_1 
on
p_lew_core.t_item.client_id = p_lew_core.t_item_relevance_classification.client_id 
and 
p_lew_core.t_item_relevance_classification.dwh_valid_to >= current_date()
and 
p_lew_core.t_item.item_sid=p_lew_core.t_item_relevance_classification.item_sid 
inner join
p_lew_core.t_wawi_itm_item_skey_1 on 
p_lew_core.t_item.client_id=p_lew_core.t_wawi_itm_item_skey.client_id 
and
p_lew_core.t_item.item_sid=p_lew_core.t_wawi_itm_item_skey.item_sid and p_lew_core.t_wawi_itm_item_skey.dat_rec_end >= current_date()-1 
left outer join
p_lew_core.t_wawi_itm_item_1 
on p_lew_core.t_item.client_id=p_lew_core.t_wawi_itm_item.client_id 
and
p_lew_core.t_item.item_sid=p_lew_core.t_wawi_itm_item.item_sid 
and 
p_lew_core.t_wawi_itm_item.dat_rec_end >= (current_date-1)

where p_lew_core.t_item_relevance_classification.client_id  =  
(
 SELECT
    CASE
        WHEN column1 = 2 THEN '2' -- BE
        WHEN column1 = 3 THEN '3'  --BG
        WHEN column1 = 4 THEN '5'  --CY
        WHEN column1 = 5 THEN '23' --DE
        WHEN column1 = 6 THEN '8'  --DK
        WHEN column1 = 7 THEN '11' --FI
        WHEN column1 = 8 THEN '12' --FR
        WHEN column1 = 9 THEN '14' --GR
        WHEN column1 = 10 THEN '13'--GB
        WHEN column1 = 11 THEN '22'--NL
        WHEN column1 = 12 THEN '17'--IE
        WHEN column1 = 13 THEN '18'--IT
        WHEN column1 = 14 THEN '31'--CS
        WHEN column1 = 15 THEN '15'--HR
        WHEN column1 = 16 THEN '19'--LT
        WHEN column1 = 17 THEN '32'--MT
        WHEN column1 = 18 THEN '21'--NI
        WHEN column1 = 19 THEN '1'--AT
        WHEN column1 = 20 THEN '24'--PL
        WHEN column1 = 21 THEN '25'--PT
        WHEN column1 = 22 THEN '26'--RO
        WHEN column1 = 23 THEN '27'--SE
        WHEN column1 = 24 THEN '4'--CH
        WHEN column1 = 25 THEN '34'--RS_1
        WHEN column1 = 26 THEN '29'--SK
        WHEN column1 = 27 THEN '28'--SI
        WHEN column1 = 28 THEN '10'--ES
        WHEN column1 = 29 THEN '6'--CZ
        WHEN column1 = 30 THEN '16'--HU
        WHEN column1 = 31 THEN '33'--US
        WHEN column1 = 33 THEN '9'--EE
        WHEN column1 = 34 THEN '20'--LV
        ELSE null
    END AS result
from (values( ${COUNTRY_ID} )) 
v
)

)

SELECT 
LPAD(CONCAT(trim(src_orig_item_nr), LPAD(src_case_size, 4, 0)), 11, 0) as orig_item_nr_int_joined,
LISTAGG(ITEM_RELEVANCE_CLASS_SCHEMA_CD, '-') WITHIN GROUP (Order BY item_sid) as zSummary,
COUNT(
DISTINCT 
CASE WHEN 
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'LBS' OR
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'OBE' OR
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'ALR' OR
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'NEW' 
THEN 1 END
) as zRelevantMDM

from CTE_BASE 
where ORIG_ITEM_NR_INT_JOINED is not null
group by item_sid, src_orig_item_nr, src_case_size, client
having 
COUNT(
DISTINCT 
CASE WHEN 
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'LBS' OR
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'OBE' OR
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'ALR' OR
    ITEM_RELEVANCE_CLASS_SCHEMA_CD = 'NEW' 
THEN 1 END
) = 1
;