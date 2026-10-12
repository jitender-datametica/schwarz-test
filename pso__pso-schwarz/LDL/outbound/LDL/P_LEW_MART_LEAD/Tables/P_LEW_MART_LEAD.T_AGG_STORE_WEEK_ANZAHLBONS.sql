/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_STORE_WEEK_ANZAHLBONS
#-------------------------------------------------------------------------------
# Description:  This table provides aggregated Bon Totals and Umsatz with 
#				the granularity of client/store/week.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-04-03 Prasanna Ranjan	 Initial Version
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_week_anzahlbons (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
move_to_store_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region surrogate key'),
cy_week INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Number of week, YYYYWW'),
previous_year_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Flag indicating if current year 0 or previous year 1'),
last_12_cy_week_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Flag indicating if in last 12 weeks'),
cnt_customer_asis BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Number of sale receipts'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, move_to_store_id, cy_week, previous_year_fg) NOT ENFORCED
) CLUSTER BY client_id, cy_week
OPTIONS(description='Table for number of receipts with weekly granularity');