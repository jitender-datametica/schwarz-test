/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Lookup View for Abrechnungsart
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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_PAYOUT_INVOICE_TYPE
(
  payout_invoice_type_cd
, payout_invoice_type_descr
) AS
SELECT
  payout_invoice_type_cd
, payout_invoice_type_descr
FROM P_LEW_CORE_AC.v_ref_payout_invoice_type
;
