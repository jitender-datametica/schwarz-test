CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ORG_WH_MERGE_BASE
(
  aspect_id
, client_id
, wh_id
, country_cd
, gl_region_id
, dat_opening
, costcenter_cd
, company
, order_buying_list_cd
, vat_region_nr
, region_cd
, stock_plain
, sponsion
, global_location_nr
, wh_desc
, distribute_wh_fg
, int_fg
, hq_fg
, prop_wh_fg
, sales_wh_fg
, supp_wh_fg
, wawi_data_fg
, ovis_data_fg
, parent_wh_id
, buying_region
)
AS
SELECT
aspect_id,
client_id,
wh_id,
country_cd,
gl_region_id,
dat_opening,
costcenter_cd,
company,
order_buying_list_cd,
vat_region_nr,
region_cd,
stock_plain,
sponsion,
global_location_nr,
wh_desc,
distribute_wh_fg,
int_fg,
hq_fg,
prop_wh_fg,
sales_wh_fg,
supp_wh_fg,
wawi_data_fg,
ovis_data_fg,
parent_wh_id,
buying_region
FROM p_lew_mart_lead.v_org_wh_merge_base;




