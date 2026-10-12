/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_ARTIKELSTAMM_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_ARTIKELSTAMM_1
(
  client_id
, country_iso_cd
, subitemgroup_id
, itemfamily_cd
, vat_id
, itemstatus_cd
, orig_item_nr
, orig_item_nr_int
, item_valid_from
, item_valid_until
, deleted_fg
, itemfamily_valid_from
, itemfamaliy_valid_until
, smallest_unit
, weight_fg
, dangerous_goods_fg
, buying_list_type_id
, brand_name
, load_id
)
AS
/* grouping is actually superfluous, because "item_1" guarantees key-ness of "client_id", "nat_item_nr", but
     we leave it in for now, in case the logic must be changed again: KZP expects grouping like this */
SELECT
item.client_id                                                                  AS client_id,
t.src_country_lidl_cd                                                           AS country_iso_cd,
item.subitemgroup_id                                                            AS subitemgroup_id,
item.itemfamily_cd                                                              AS itemfamily_cd,
item.vat_id                                                                     AS vat_id,
item.itemstatus_cd                                                              AS itemstatus_cd,
item.orig_item_nr                                                               AS orig_item_nr,
item.orig_item_nr_int                                                           AS orig_item_nr_int,
item.item_valid_from                                                            AS item_valid_from,
item.item_valid_until                                                           AS item_valid_until,
item.deleted_fg                                                                 AS deleted_fg,
item.itemfamily_valid_from                                                      AS itemfamily_valid_from,
item.itemfamaliy_valid_until                                                    AS itemfamaliy_valid_until,
CASE  WHEN CONTAINS( item.smallest_unit, 'NA') THEN NULL ELSE item.smallest_unit END AS smallest_unit,
COALESCE(item.weight_fg,0)                                                      AS weight_fg,
item.dangerous_goods_fg                                                         AS dangerous_goods_fg,
item.buying_list_type_id                                                        AS buying_list_type_id,
item.brand_name                                                                 AS brand_name,
item.dwh_load_id                                                                AS load_id
FROM (SELECT
m.client_id,
m.item_sid,
m.subitemgroup_id,
m.item_familygroup_id,
m.vat_id,
m.itemstatus_cd,
m.orig_item_nr,
m.orig_item_nr_int,
m.valid_from           AS item_valid_from,
m.valid_until          AS item_valid_until,
m.deleted_fg,
m.smallest_unit,
m.weight_fg,
m.dangerous_goods_fg,
m.buying_list_type_id,
m.brand_name,
i.itemfamily_cd,
i.dat_rec_start       AS itemfamily_valid_from,
i.dat_rec_end         AS itemfamaliy_valid_until,
m.dwh_load_id
FROM p_lew_mart_cs.v_gen_item_hist_1 m

LEFT OUTER JOIN (SELECT
client_id,
item_familygroup_id,
itemfamily_cd,
dat_rec_start,
dat_rec_end
FROM p_lew_mart_cs.v_gen_item_family_1
                               GROUP BY 1,2,3,4,5
                               ) i
           ON i.client_id = m.client_id
           AND i.item_familygroup_id = m.item_familygroup_id

           WHERE m.deleted_fg = 0
       )item_1

   -- Country_1
   INNER JOIN p_lew_core_ac.v_client_1 c
ON item.client_id = c.client_id

INNER JOIN p_lew_core_ac.v_country_1 t
ON c.country_sid = t.country_sid
;


