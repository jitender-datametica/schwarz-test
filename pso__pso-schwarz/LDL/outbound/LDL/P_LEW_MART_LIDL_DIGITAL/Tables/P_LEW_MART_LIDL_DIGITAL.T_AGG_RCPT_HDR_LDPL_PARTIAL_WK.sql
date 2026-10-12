/*#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-06-24 Patrick Mittler         [SF] remove COLLATE to improve performance
#  1.1 2022-04-01 Pawel Wieczorek         AP0092849 AP0092849 drop column customer_segment_cd, add comments from Teradata
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_partial_wk (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
wh_id BIGNUMERIC(38,0) OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Week number'),
cy_week_part BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Part of the week, in non transit week: value 1, in transit week: in the first part of week - value 1, in the second part of week - value 2 '),
cy_week_partial_week_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Partial week unique id: cy_week || cy_week_part '),
cy_partial_week_name STRING(27) OPTIONS(description='Partial week name '),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
cwpart_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Current Partial week'),
cwpart_tot_gros_val NUMERIC(18,5) OPTIONS(description='Total gross value : Current Partial week'),
cwpart_tot_net_val NUMERIC(18,5) OPTIONS(description='Total net value : Current Partial week'),
cwpart_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Current Partial week'),
cwpart_tot_rcpt_cnt_wk NUMERIC(18,5) OPTIONS(description='Total receipts count : Current Partial week'),
cwpart_trans_time_in_mins NUMERIC(18,5)
OPTIONS(description='Transaction time measured in minutes : Current Partial week'),
cwpart_items_scanned_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of items scanned : Current Partial week'),
cwpart_discount_val NUMERIC(18,5) OPTIONS(description='Discount value : Current Partial week'),
pywpart_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Previous year partial week'),
pywpart_tot_gros_val NUMERIC(18,5) OPTIONS(description='Total gross value : Previous year partial week'),
pywpart_tot_net_val NUMERIC(18,5) OPTIONS(description='Total net value : Previous year partial week'),
pywpart_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Previous year partial week'),
pywpart_tot_rcpt_cnt_wk NUMERIC(18,5) OPTIONS(description='Total receipts count : Previous year partial week'),
pywpart_trans_time_in_mins NUMERIC(18,5)
OPTIONS(description='Transaction time measured in minutes : Previous year partial week'),
pywpart_items_scanned_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of items scanned : Previous year partial week'),
pywpart_discount_val NUMERIC(18,5) OPTIONS(description='Discount value : Previous year partial week'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, move_to_store_id, lidlplus_cust_fg, currency_iso_cd) NOT ENFORCED
) OPTIONS(description='Lidlplus : Receipt header aggregated to partial week level');