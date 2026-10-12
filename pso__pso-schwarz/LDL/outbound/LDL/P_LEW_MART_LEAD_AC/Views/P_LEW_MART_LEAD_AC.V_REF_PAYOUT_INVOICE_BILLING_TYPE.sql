/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Lookup View for Abrechnungstyp
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2024-04-17   Torsten Bachmann    Initial version, AP0162679, NRV base KPI
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_payout_invoice_billing_type (payout_invoice_billing_type_cd,
payout_invoice_billing_type_descr, sales_amount_based_calc_fg OPTIONS(description='1=WE EK ohne SK * payout_cond_pct'),
sales_qty_based_calc_fg OPTIONS(description='0=WE Stk * payout_cond_net_val')) AS SELECT payout_invoice_billing_type_cd
 ,
 payout_invoice_billing_type_descr,
 sales_amount_based_calc_fg,
 sales_qty_based_calc_fg
FROM ldl_p_lew_core_ac.v_ref_payout_invoice_billing_type;